/**
 * Turns the client's posters (in /Products) into product photos:
 *  - productShot(): the product cut out of its poster, set on a soft, blurred version of the same scene, as a square photo.
 *  - posterImage(): the whole poster, resized, for the product page.
 */
import path from "node:path";

import sharp, { type OverlayOptions } from "sharp";

import type { Rect, Shot } from "./real-products.data";

export const POSTER_DIR = path.resolve(process.cwd(), "Products");

/** Poster numbers follow the screenshot order in /Products (oldest first), skipping the " - Copy" duplicate. */
export async function posterFiles(): Promise<string[]> {
  const { readdir } = await import("node:fs/promises");
  return (await readdir(POSTER_DIR))
    .filter((f) => f.toLowerCase().endsWith(".png") && !f.includes(" - Copy"))
    .sort()
    .map((f) => path.join(POSTER_DIR, f));
}

const SIZE = 900;

const px = (r: Rect, w: number, h: number) => {
  const left = Math.max(0, Math.round(r[0] * w));
  const top = Math.max(0, Math.round(r[1] * h));
  const right = Math.min(w, Math.round(r[2] * w));
  const bottom = Math.min(h, Math.round(r[3] * h));
  return { left, top, width: right - left, height: bottom - top };
};

/** Softens badges and stickers so no poster text ends up in the product photo. */
async function withBlurredAreas(file: string, blur: Rect[] = []): Promise<Buffer> {
  const base = sharp(file).removeAlpha();
  const { width = 0, height = 0 } = await base.metadata();
  if (!blur.length) return base.png().toBuffer();
  const patches = [];
  for (const r of blur) {
    const box = px(r, width, height);
    if (box.width < 2 || box.height < 2) continue;
    const patch = await sharp(file).removeAlpha().extract(box).blur(Math.max(12, Math.round(Math.min(box.width, box.height) / 4))).toBuffer();
    patches.push({ input: patch, left: box.left, top: box.top });
  }
  return base.composite(patches).png().toBuffer();
}

async function averageColour(img: Buffer): Promise<{ r: number; g: number; b: number }> {
  const { data } = await sharp(img).resize(1, 1, { fit: "fill" }).removeAlpha().raw().toBuffer({ resolveWithObject: true });
  return { r: data[0], g: data[1], b: data[2] };
}

/** Stretches thin strips from the crop's outer edges into the empty margins, so the fill matches the scene around the product. */
async function extendedBackground(crop: Buffer, W: number, H: number, fw: number, fh: number, featherX: number, featherY: number, fillFromTop = false): Promise<Buffer> {
  const layers: OverlayOptions[] = [];
  let edges: Buffer[] = [];
  if (fw < SIZE) {
    const strip = Math.max(3, Math.round(W * 0.04));
    const sideW = Math.ceil((SIZE - fw) / 2) + featherX + 2;
    const left = await sharp(crop).extract({ left: 0, top: 0, width: strip, height: H }).toBuffer();
    const right = await sharp(crop).extract({ left: W - strip, top: 0, width: strip, height: H }).toBuffer();
    edges = [left, right];
    layers.push(
      { input: await sharp(left).resize(sideW, SIZE, { fit: "fill" }).toBuffer(), left: 0, top: 0 },
      { input: await sharp(right).resize(sideW, SIZE, { fit: "fill" }).toBuffer(), left: SIZE - sideW, top: 0 },
    );
  } else if (fh < SIZE) {
    // Wide crops: products often touch the top/bottom edge, so stretching would draw coloured columns.
    // Fill each margin with the plain average colour of that edge instead; the blur blends them softly.
    const strip = Math.max(3, Math.round(H * 0.04));
    const sideH = Math.ceil((SIZE - fh) / 2) + featherY + 2;
    const top = await sharp(crop).extract({ left: 0, top: 0, width: W, height: strip }).toBuffer();
    const bottom = await sharp(crop).extract({ left: 0, top: H - strip, width: W, height: strip }).toBuffer();
    edges = [top, bottom];
    const tc = await averageColour(top);
    const bc = fillFromTop ? tc : await averageColour(bottom);
    layers.push(
      { input: await sharp({ create: { width: SIZE, height: sideH, channels: 3, background: tc } }).png().toBuffer(), left: 0, top: 0 },
      { input: await sharp({ create: { width: SIZE, height: sideH, channels: 3, background: bc } }).png().toBuffer(), left: 0, top: SIZE - sideH },
    );
  }
  const colours = await Promise.all((edges.length ? edges : [crop]).map(averageColour));
  const avg = {
    r: Math.round(colours.reduce((s, c) => s + c.r, 0) / colours.length),
    g: Math.round(colours.reduce((s, c) => s + c.g, 0) / colours.length),
    b: Math.round(colours.reduce((s, c) => s + c.b, 0) / colours.length),
  };
  const base = await sharp({ create: { width: SIZE, height: SIZE, channels: 3, background: avg } }).composite(layers).png().toBuffer();
  return sharp(base).blur(22).toBuffer();
}

export async function productShot(files: string[], shot: Shot): Promise<Buffer> {
  const file = files[shot.poster - 1];
  if (!file) throw new Error(`Poster #${shot.poster} not found`);
  const src = await withBlurredAreas(file, shot.blur);
  const { width = 0, height = 0 } = await sharp(src).metadata();
  const crop = await sharp(src).extract(px(shot.rect, width, height)).png().toBuffer();
  const meta = await sharp(crop).metadata();

  const W = meta.width ?? SIZE;
  const H = meta.height ?? SIZE;

  // Foreground: the sharp crop, as large as fits, with feathered edges where it meets the soft fill.
  const scale = Math.min(SIZE / W, SIZE / H);
  const fw = Math.round(W * scale);
  const fh = Math.round(H * scale);
  const featherX = fw < SIZE - 4 ? Math.round(fw * 0.08) : 0;
  const featherY = fh < SIZE - 4 ? Math.round(fh * 0.08) : 0;

  // Background: the scene continued outwards from the crop's own outer edges (never the product itself), then blurred.
  const background = await extendedBackground(crop, W, H, fw, fh, featherX, featherY, shot.fillFromTop);
  const mask = Buffer.from(
    `<svg width="${fw}" height="${fh}" xmlns="http://www.w3.org/2000/svg">
      <defs>
        <linearGradient id="h" x1="0" x2="1" y1="0" y2="0">
          <stop offset="0" stop-color="#fff" stop-opacity="${featherX ? 0 : 1}"/>
          <stop offset="${featherX / fw}" stop-color="#fff" stop-opacity="1"/>
          <stop offset="${1 - featherX / fw}" stop-color="#fff" stop-opacity="1"/>
          <stop offset="1" stop-color="#fff" stop-opacity="${featherX ? 0 : 1}"/>
        </linearGradient>
        <linearGradient id="v" x1="0" x2="0" y1="0" y2="1">
          <stop offset="0" stop-color="#fff" stop-opacity="${featherY ? 0 : 1}"/>
          <stop offset="${featherY / fh}" stop-color="#fff" stop-opacity="1"/>
          <stop offset="${1 - featherY / fh}" stop-color="#fff" stop-opacity="1"/>
          <stop offset="1" stop-color="#fff" stop-opacity="${featherY ? 0 : 1}"/>
        </linearGradient>
        <mask id="m"><rect width="100%" height="100%" fill="url(#h)"/></mask>
      </defs>
      <rect width="100%" height="100%" fill="url(#v)" mask="url(#m)"/>
    </svg>`,
  );
  const foreground = await sharp(crop)
    .resize(fw, fh, { kernel: "lanczos3" })
    .ensureAlpha()
    .composite([{ input: await sharp(mask).resize(fw, fh).png().toBuffer(), blend: "dest-in" }])
    .png()
    .toBuffer();

  return sharp(background)
    .composite([{ input: foreground, left: Math.round((SIZE - fw) / 2), top: Math.round((SIZE - fh) / 2) }])
    .sharpen({ sigma: 0.5 })
    .webp({ quality: 86 })
    .toBuffer();
}

export async function posterImage(files: string[], poster: number): Promise<Buffer> {
  const file = files[poster - 1];
  if (!file) throw new Error(`Poster #${poster} not found`);
  // Some screenshots have black bars (letterboxing); trim them so the poster shows cleanly.
  const trimmed = await sharp(file).removeAlpha().trim({ background: "#000000", threshold: 18 }).toBuffer();
  return sharp(trimmed).resize({ height: 1400, width: 1400, fit: "inside", withoutEnlargement: true }).webp({ quality: 86 }).toBuffer();
}
