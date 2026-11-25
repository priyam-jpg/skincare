// Shares the local store on a temporary public link (Cloudflare quick tunnel).
// Usage: npm run share        (optional: npm run share -- 3062  to use another port)
// The link works while this window stays open and the computer is awake. Ctrl+C stops everything.
import { spawn, spawnSync } from "node:child_process";
import { existsSync } from "node:fs";
import net from "node:net";
import path from "node:path";

const root = path.resolve(import.meta.dirname, "..");
const port = Number(process.argv[2] || 3061);
const win = process.platform === "win32";

const cloudflared = [
  process.env.CLOUDFLARED,
  "C:\\Program Files (x86)\\cloudflared\\cloudflared.exe",
  "C:\\Program Files\\cloudflared\\cloudflared.exe",
].find((p) => p && existsSync(p)) || "cloudflared";

const children = [];
const stop = (code = 0) => {
  for (const c of children) {
    try {
      if (win) spawnSync("taskkill", ["/PID", String(c.pid), "/T", "/F"], { stdio: "ignore" });
      else c.kill();
    } catch {}
  }
  process.exit(code);
};
process.on("SIGINT", () => stop(0));

const canListen = (p, host) =>
  new Promise((resolve) => {
    const s = net.createServer().once("error", () => resolve(false)).once("listening", () => s.close(() => resolve(true)));
    s.listen(p, host);
  });
// Next listens on IPv6 (::) on Windows, so a port can look free on 127.0.0.1 while it is taken. Check both.
const portFree = async (p) => (await canListen(p, "::")) && (await canListen(p, "127.0.0.1"));

console.log("1/4  Starting the database...");
spawnSync("node", [path.join(root, "scripts", "db.mjs"), "start"], { stdio: "inherit" });

if (!(await portFree(port))) {
  console.error(`Port ${port} is already in use. Stop whatever is using it, or run: npm run share -- ${port + 1}`);
  process.exit(1);
}

console.log("2/4  Opening the public link...");
const tunnel = spawn(cloudflared, ["tunnel", "--no-autoupdate", "--url", `http://localhost:${port}`], { stdio: ["ignore", "pipe", "pipe"] });
children.push(tunnel);
tunnel.on("error", () => {
  console.error("Could not start cloudflared. Install it with: winget install --id Cloudflare.cloudflared -e");
  stop(1);
});
const url = await new Promise((resolve, reject) => {
  const timer = setTimeout(() => reject(new Error("No link from Cloudflare after 60 s. Check your internet connection and try again.")), 60000);
  const onData = (buf) => {
    const m = String(buf).match(/https:\/\/[a-z0-9-]+\.trycloudflare\.com/);
    if (m) {
      clearTimeout(timer);
      resolve(m[0]);
    }
  };
  tunnel.stdout.on("data", onData);
  tunnel.stderr.on("data", onData);
}).catch((err) => {
  console.error(err.message);
  stop(1);
});

// The site needs to know its public address at build time (logins and the admin check it).
const env = { ...process.env, NEXT_PUBLIC_SERVER_URL: url };

console.log("3/4  Building the site for that link (1-3 minutes)...");
const build = spawnSync("npm run build", { cwd: root, env, stdio: "inherit", shell: true });
if (build.status !== 0) {
  console.error("The build failed; see the messages above.");
  stop(1);
}

console.log("4/4  Starting the site...");
const server = spawn(`npx next start -p ${port}`, { cwd: root, env, stdio: "inherit", shell: true });
children.push(server);
let ready = false;
server.on("exit", (code) => {
  if (!ready) console.error("\nThe site could not start (see the error above), so the link was closed. Fix that and run npm run share again.");
  stop(code ?? 1);
});

// Only hand out the link once the site actually answers.
for (let i = 0; i < 120 && !ready; i++) {
  try {
    await fetch(`http://localhost:${port}/`, { signal: AbortSignal.timeout(20000) });
    ready = true;
  } catch {
    await new Promise((r) => setTimeout(r, 1000));
  }
}
if (!ready) {
  console.error("The site did not respond within 2 minutes.");
  stop(1);
}

console.log(`
  ----------------------------------------------
  Your demo link:  ${url}
  Admin:           ${url}/admin
  ----------------------------------------------
  Works while this window stays open and the computer is awake.
  Press Ctrl+C to stop. Each start gives a new link.
`);
