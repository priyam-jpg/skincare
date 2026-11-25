// The project's own Postgres (data in ./.pgdata, port 5433).
// Usage: node scripts/db.mjs start|stop|status|init|restore
//   init     creates ./.pgdata with the user, password and database named in .env DATABASE_URL, then starts it
//   restore  loads handover/database.sql (products, categories, photos list, homepage) into DATABASE_URL
// Postgres is started detached so Ctrl+C in the dev-server terminal does not kill it.
import { spawn, spawnSync } from "node:child_process";
import { existsSync, mkdtempSync, rmSync, writeFileSync } from "node:fs";
import os from "node:os";
import path from "node:path";

const action = process.argv[2] || "start";
const root = path.resolve(import.meta.dirname, "..");
const dataDir = path.join(root, ".pgdata");

function findPgTool(name) {
  const exe = process.platform === "win32" ? `${name}.exe` : name;
  const candidates = [];
  if (process.env.PG_BIN) candidates.push(path.join(process.env.PG_BIN, exe));
  if (process.platform === "win32") {
    for (const v of ["18", "17", "16", "15"]) candidates.push(`C:\\Program Files\\PostgreSQL\\${v}\\bin\\${exe}`);
  }
  return candidates.find((c) => existsSync(c)) || exe; // fall back to PATH
}

function databaseUrl() {
  if (existsSync(path.join(root, ".env"))) process.loadEnvFile(path.join(root, ".env"));
  if (!process.env.DATABASE_URL) {
    console.error("DATABASE_URL is missing. Copy .env.example to .env and fill it in first.");
    process.exit(1);
  }
  return new URL(process.env.DATABASE_URL);
}

const pgCtl = findPgTool("pg_ctl");
const run = (args) => spawnSync(pgCtl, ["-D", dataDir, ...args], { stdio: "inherit" }).status ?? 1;

if (action === "start") {
  if (run(["status"]) === 0) {
    console.log("Database already running on port 5433.");
    process.exit(0);
  }
  const child = spawn(pgCtl, ["-D", dataDir, "-o", "-p 5433", "-l", path.join(dataDir, "server.log"), "-w", "-t", "120", "start"], {
    detached: true,
    stdio: "ignore",
    windowsHide: true,
  });
  child.on("exit", (code) => {
    if (code === 0) console.log("Database running on port 5433.");
    else console.error(`Database failed to start (code ${code}). See .pgdata/server.log`);
    process.exit(code ?? 1);
  });
} else if (action === "stop") {
  process.exit(run(["-m", "fast", "stop"]));
} else if (action === "init") {
  if (existsSync(dataDir)) {
    console.error(".pgdata already exists. Run `npm run db:start` instead.");
    process.exit(1);
  }
  const url = databaseUrl();
  const user = decodeURIComponent(url.username);
  const password = decodeURIComponent(url.password);
  const dbName = url.pathname.slice(1);
  if (url.port !== "5433" || !user || !password || !dbName) {
    console.error("For the local database, DATABASE_URL must look like postgres://USER:PASSWORD@127.0.0.1:5433/DBNAME");
    process.exit(1);
  }
  const tmp = mkdtempSync(path.join(os.tmpdir(), "pgpw-"));
  const pwFile = path.join(tmp, "pw");
  writeFileSync(pwFile, password);
  const init = spawnSync(findPgTool("initdb"), ["-D", dataDir, "-U", user, "-A", "scram-sha-256", `--pwfile=${pwFile}`, "-E", "UTF8"], { stdio: "inherit" });
  rmSync(tmp, { recursive: true, force: true });
  if (init.status !== 0) process.exit(init.status ?? 1);
  const start = spawnSync(process.execPath, [import.meta.filename, "start"], { stdio: "inherit" });
  if (start.status !== 0) process.exit(start.status ?? 1);
  const adminUrl = new URL(url);
  adminUrl.pathname = "/postgres";
  const create = spawnSync(findPgTool("psql"), [adminUrl.href, "-qc", `create database "${dbName}"`], { stdio: "inherit" });
  if (create.status !== 0) process.exit(create.status ?? 1);
  console.log(`Created database "${dbName}". Next: npm run db:restore`);
} else if (action === "restore") {
  const url = databaseUrl();
  const psql = findPgTool("psql");
  const check = spawnSync(psql, [url.href, "-Atc", "select to_regclass('public.products') is not null"], { encoding: "utf8" });
  if (check.status !== 0) {
    console.error(check.stderr || "Could not connect to the database. Is it running (npm run db:start)?");
    process.exit(1);
  }
  if (check.stdout.trim() === "t") {
    console.error("This database already has store tables. Restore only into an empty database.");
    process.exit(1);
  }
  const res = spawnSync(psql, [url.href, "-q", "-v", "ON_ERROR_STOP=1", "-f", path.join(root, "handover", "database.sql")], { stdio: ["ignore", "ignore", "inherit"] });
  if (res.status !== 0) process.exit(res.status ?? 1);
  console.log("Restored: 45 products, categories, photos list and homepage. Open /admin and create your admin account.");
} else {
  process.exit(run(["status"]));
}
