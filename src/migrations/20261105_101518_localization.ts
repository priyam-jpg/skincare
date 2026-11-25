import { MigrateUpArgs, MigrateDownArgs, sql } from '@payloadcms/db-postgres'

export async function up({ db, payload, req }: MigrateUpArgs): Promise<void> {
  await db.execute(sql`
   CREATE TYPE "public"."_locales" AS ENUM('de', 'fr', 'it', 'en');
  CREATE TYPE "public"."enum__variants_v_published_locale" AS ENUM('de', 'fr', 'it', 'en');
  CREATE TYPE "public"."enum__products_v_published_locale" AS ENUM('de', 'fr', 'it', 'en');
  CREATE TABLE "categories_locales" (
  	"title" varchar NOT NULL,
  	"id" serial PRIMARY KEY NOT NULL,
  	"_locale" "_locales" NOT NULL,
  	"_parent_id" integer NOT NULL
  );
  
  CREATE TABLE "products_locales" (
  	"title" varchar,
  	"tagline" varchar,
  	"description" varchar,
  	"how_to_use" varchar,
  	"ingredients" varchar,
  	"id" serial PRIMARY KEY NOT NULL,
  	"_locale" "_locales" NOT NULL,
  	"_parent_id" integer NOT NULL
  );
  
  CREATE TABLE "_products_v_locales" (
  	"version_title" varchar,
  	"version_tagline" varchar,
  	"version_description" varchar,
  	"version_how_to_use" varchar,
  	"version_ingredients" varchar,
  	"id" serial PRIMARY KEY NOT NULL,
  	"_locale" "_locales" NOT NULL,
  	"_parent_id" integer NOT NULL
  );
  
  CREATE TABLE "home_announcements_locales" (
  	"text" varchar NOT NULL,
  	"id" serial PRIMARY KEY NOT NULL,
  	"_locale" "_locales" NOT NULL,
  	"_parent_id" varchar NOT NULL
  );
  
  CREATE TABLE "home_routine_locales" (
  	"title" varchar NOT NULL,
  	"note" varchar,
  	"id" serial PRIMARY KEY NOT NULL,
  	"_locale" "_locales" NOT NULL,
  	"_parent_id" varchar NOT NULL
  );
  
  CREATE TABLE "home_locales" (
  	"hero_title" varchar DEFAULT 'Skincare that fits every skin.',
  	"hero_lede" varchar DEFAULT 'Korean-formulated routines, made simple and gentle on every skin.',
  	"id" serial PRIMARY KEY NOT NULL,
  	"_locale" "_locales" NOT NULL,
  	"_parent_id" integer NOT NULL
  );
  
  ALTER TABLE "_variants_v" ADD COLUMN "snapshot" boolean;
  ALTER TABLE "_variants_v" ADD COLUMN "published_locale" "enum__variants_v_published_locale";
  ALTER TABLE "_products_v" ADD COLUMN "snapshot" boolean;
  ALTER TABLE "_products_v" ADD COLUMN "published_locale" "enum__products_v_published_locale";
  ALTER TABLE "categories_locales" ADD CONSTRAINT "categories_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."categories"("id") ON DELETE cascade ON UPDATE no action;
  ALTER TABLE "products_locales" ADD CONSTRAINT "products_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."products"("id") ON DELETE cascade ON UPDATE no action;
  ALTER TABLE "_products_v_locales" ADD CONSTRAINT "_products_v_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."_products_v"("id") ON DELETE cascade ON UPDATE no action;
  ALTER TABLE "home_announcements_locales" ADD CONSTRAINT "home_announcements_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."home_announcements"("id") ON DELETE cascade ON UPDATE no action;
  ALTER TABLE "home_routine_locales" ADD CONSTRAINT "home_routine_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."home_routine"("id") ON DELETE cascade ON UPDATE no action;
  ALTER TABLE "home_locales" ADD CONSTRAINT "home_locales_parent_id_fk" FOREIGN KEY ("_parent_id") REFERENCES "public"."home"("id") ON DELETE cascade ON UPDATE no action;
  CREATE UNIQUE INDEX "categories_locales_locale_parent_id_unique" ON "categories_locales" USING btree ("_locale","_parent_id");
  CREATE INDEX "categories_locales_parent_id_idx" ON "categories_locales" USING btree ("_parent_id");
  CREATE UNIQUE INDEX "products_locales_locale_parent_id_unique" ON "products_locales" USING btree ("_locale","_parent_id");
  CREATE INDEX "products_locales_parent_id_idx" ON "products_locales" USING btree ("_parent_id");
  CREATE UNIQUE INDEX "_products_v_locales_locale_parent_id_unique" ON "_products_v_locales" USING btree ("_locale","_parent_id");
  CREATE INDEX "_products_v_locales_parent_id_idx" ON "_products_v_locales" USING btree ("_parent_id");
  CREATE UNIQUE INDEX "home_announcements_locales_locale_parent_id_unique" ON "home_announcements_locales" USING btree ("_locale","_parent_id");
  CREATE INDEX "home_announcements_locales_parent_id_idx" ON "home_announcements_locales" USING btree ("_parent_id");
  CREATE UNIQUE INDEX "home_routine_locales_locale_parent_id_unique" ON "home_routine_locales" USING btree ("_locale","_parent_id");
  CREATE INDEX "home_routine_locales_parent_id_idx" ON "home_routine_locales" USING btree ("_parent_id");
  CREATE UNIQUE INDEX "home_locales_locale_parent_id_unique" ON "home_locales" USING btree ("_locale","_parent_id");
  CREATE INDEX "home_locales_parent_id_idx" ON "home_locales" USING btree ("_parent_id");
  CREATE INDEX "_variants_v_snapshot_idx" ON "_variants_v" USING btree ("snapshot");
  CREATE INDEX "_variants_v_published_locale_idx" ON "_variants_v" USING btree ("published_locale");
  CREATE INDEX "_products_v_snapshot_idx" ON "_products_v" USING btree ("snapshot");
  CREATE INDEX "_products_v_published_locale_idx" ON "_products_v" USING btree ("published_locale");
  ALTER TABLE "categories" DROP COLUMN "title";
  ALTER TABLE "products" DROP COLUMN "title";
  ALTER TABLE "products" DROP COLUMN "tagline";
  ALTER TABLE "products" DROP COLUMN "description";
  ALTER TABLE "products" DROP COLUMN "how_to_use";
  ALTER TABLE "products" DROP COLUMN "ingredients";
  ALTER TABLE "_products_v" DROP COLUMN "version_title";
  ALTER TABLE "_products_v" DROP COLUMN "version_tagline";
  ALTER TABLE "_products_v" DROP COLUMN "version_description";
  ALTER TABLE "_products_v" DROP COLUMN "version_how_to_use";
  ALTER TABLE "_products_v" DROP COLUMN "version_ingredients";
  ALTER TABLE "home_announcements" DROP COLUMN "text";
  ALTER TABLE "home_routine" DROP COLUMN "title";
  ALTER TABLE "home_routine" DROP COLUMN "note";
  ALTER TABLE "home" DROP COLUMN "hero_title";
  ALTER TABLE "home" DROP COLUMN "hero_lede";`)
}

export async function down({ db, payload, req }: MigrateDownArgs): Promise<void> {
  await db.execute(sql`
   ALTER TABLE "categories_locales" DISABLE ROW LEVEL SECURITY;
  ALTER TABLE "products_locales" DISABLE ROW LEVEL SECURITY;
  ALTER TABLE "_products_v_locales" DISABLE ROW LEVEL SECURITY;
  ALTER TABLE "home_announcements_locales" DISABLE ROW LEVEL SECURITY;
  ALTER TABLE "home_routine_locales" DISABLE ROW LEVEL SECURITY;
  ALTER TABLE "home_locales" DISABLE ROW LEVEL SECURITY;
  DROP TABLE "categories_locales" CASCADE;
  DROP TABLE "products_locales" CASCADE;
  DROP TABLE "_products_v_locales" CASCADE;
  DROP TABLE "home_announcements_locales" CASCADE;
  DROP TABLE "home_routine_locales" CASCADE;
  DROP TABLE "home_locales" CASCADE;
  DROP INDEX "_variants_v_snapshot_idx";
  DROP INDEX "_variants_v_published_locale_idx";
  DROP INDEX "_products_v_snapshot_idx";
  DROP INDEX "_products_v_published_locale_idx";
  ALTER TABLE "categories" ADD COLUMN "title" varchar NOT NULL;
  ALTER TABLE "products" ADD COLUMN "title" varchar;
  ALTER TABLE "products" ADD COLUMN "tagline" varchar;
  ALTER TABLE "products" ADD COLUMN "description" varchar;
  ALTER TABLE "products" ADD COLUMN "how_to_use" varchar;
  ALTER TABLE "products" ADD COLUMN "ingredients" varchar;
  ALTER TABLE "_products_v" ADD COLUMN "version_title" varchar;
  ALTER TABLE "_products_v" ADD COLUMN "version_tagline" varchar;
  ALTER TABLE "_products_v" ADD COLUMN "version_description" varchar;
  ALTER TABLE "_products_v" ADD COLUMN "version_how_to_use" varchar;
  ALTER TABLE "_products_v" ADD COLUMN "version_ingredients" varchar;
  ALTER TABLE "home_announcements" ADD COLUMN "text" varchar NOT NULL;
  ALTER TABLE "home_routine" ADD COLUMN "title" varchar NOT NULL;
  ALTER TABLE "home_routine" ADD COLUMN "note" varchar;
  ALTER TABLE "home" ADD COLUMN "hero_title" varchar DEFAULT 'Skincare that fits every skin.';
  ALTER TABLE "home" ADD COLUMN "hero_lede" varchar DEFAULT 'Korean-formulated routines, made simple and gentle on every skin.';
  ALTER TABLE "_variants_v" DROP COLUMN "snapshot";
  ALTER TABLE "_variants_v" DROP COLUMN "published_locale";
  ALTER TABLE "_products_v" DROP COLUMN "snapshot";
  ALTER TABLE "_products_v" DROP COLUMN "published_locale";
  DROP TYPE "public"."_locales";
  DROP TYPE "public"."enum__variants_v_published_locale";
  DROP TYPE "public"."enum__products_v_published_locale";`)
}
