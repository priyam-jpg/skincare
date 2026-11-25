/**
 * Placeholder product photography, drawn as SVG and rasterised by sharp in the seed.
 * Replace with real photos in the admin (Products → Photos) before launch.
 */
export type ArtKind = "tube" | "jar" | "dropper" | "pump" | "pouch" | "stick";

const INK = "#23262B";
const CAP = "#FFFEFA";

function bottle(kind: ArtKind, tint: string): string {
  switch (kind) {
    case "tube":
      return `<path d="M38 40 h44 l4 94 a6 6 0 0 1-6 6 H40 a6 6 0 0 1-6-6 z" fill="${tint}"/>
        <path d="M38 40 h44 l.6 14 H37.4 z" fill="${INK}" opacity="0.12"/>
        <rect x="44" y="18" width="32" height="22" rx="4" fill="${CAP}" stroke="${INK}" stroke-opacity="0.25"/>
        <rect x="44" y="76" width="32" height="2" rx="1" fill="${CAP}" opacity="0.9"/>
        <rect x="48" y="86" width="24" height="2" rx="1" fill="${CAP}" opacity="0.6"/>
        <path d="M42 56 v70" stroke="${CAP}" stroke-opacity="0.35" stroke-width="3" stroke-linecap="round"/>`;
    case "jar":
      return `<rect x="22" y="62" width="76" height="78" rx="12" fill="${tint}"/>
        <rect x="18" y="38" width="84" height="30" rx="8" fill="${CAP}" stroke="${INK}" stroke-opacity="0.25"/>
        <rect x="18" y="58" width="84" height="6" fill="#B32E5C" opacity="0.85"/>
        <rect x="36" y="94" width="48" height="2" rx="1" fill="${CAP}" opacity="0.9"/>
        <rect x="42" y="104" width="36" height="2" rx="1" fill="${CAP}" opacity="0.6"/>
        <path d="M30 76 v52" stroke="${CAP}" stroke-opacity="0.35" stroke-width="3" stroke-linecap="round"/>`;
    case "dropper":
      return `<rect x="34" y="62" width="52" height="78" rx="10" fill="${tint}"/>
        <rect x="42" y="50" width="36" height="14" rx="3" fill="${CAP}" stroke="${INK}" stroke-opacity="0.25"/>
        <path d="M50 50 v-26 a10 10 0 0 1 20 0 v26 z" fill="${INK}" opacity="0.85"/>
        <rect x="44" y="92" width="32" height="2" rx="1" fill="${CAP}" opacity="0.9"/>
        <rect x="48" y="102" width="24" height="2" rx="1" fill="${CAP}" opacity="0.6"/>
        <path d="M42 72 v56" stroke="${CAP}" stroke-opacity="0.35" stroke-width="3" stroke-linecap="round"/>`;
    case "pump":
      return `<rect x="32" y="56" width="56" height="86" rx="10" fill="${tint}"/>
        <rect x="52" y="40" width="16" height="18" rx="2" fill="${CAP}" stroke="${INK}" stroke-opacity="0.25"/>
        <path d="M52 40 v-12 h30 a4 4 0 0 1 0 8 h-14" fill="none" stroke="${INK}" stroke-opacity="0.85" stroke-width="6" stroke-linecap="round" stroke-linejoin="round"/>
        <rect x="42" y="88" width="36" height="2" rx="1" fill="${CAP}" opacity="0.9"/>
        <rect x="46" y="98" width="28" height="2" rx="1" fill="${CAP}" opacity="0.6"/>
        <path d="M40 68 v62" stroke="${CAP}" stroke-opacity="0.35" stroke-width="3" stroke-linecap="round"/>`;
    case "pouch":
      return `<path d="M30 30 h60 l4 108 a6 6 0 0 1-6 6 H32 a6 6 0 0 1-6-6 z" fill="${tint}"/>
        <path d="M30 30 h60 l.3 8 H29.7 z" fill="${INK}" opacity="0.12"/>
        <rect x="38" y="68" width="44" height="26" rx="5" fill="${CAP}" opacity="0.9"/>
        <rect x="44" y="104" width="32" height="2" rx="1" fill="${CAP}" opacity="0.8"/>`;
    case "stick":
      return `<rect x="42" y="48" width="36" height="92" rx="8" fill="${tint}"/>
        <rect x="46" y="22" width="28" height="30" rx="6" fill="${CAP}" stroke="${INK}" stroke-opacity="0.25"/>
        <rect x="52" y="94" width="16" height="2" rx="1" fill="${CAP}" opacity="0.9"/>
        <rect x="54" y="104" width="12" height="2" rx="1" fill="${CAP}" opacity="0.6"/>
        <path d="M48 58 v70" stroke="${CAP}" stroke-opacity="0.35" stroke-width="3" stroke-linecap="round"/>`;
  }
}

const shadow = `<ellipse cx="60" cy="146" rx="40" ry="6" fill="${INK}" opacity="0.1"/>`;

/** Main photo: the product on a soft pink studio sweep. */
export function packshotSVG(kind: ArtKind, tint: string): string {
  return `<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" viewBox="0 0 1000 1000">
  <defs>
    <radialGradient id="bg" cx="50%" cy="38%" r="75%">
      <stop offset="0" stop-color="#FFF7FA"/><stop offset="1" stop-color="#FBD4E0"/>
    </radialGradient>
    <linearGradient id="floor" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#FFE9F0"/><stop offset="1" stop-color="#F8C9D7"/>
    </linearGradient>
  </defs>
  <rect width="1000" height="1000" fill="url(#bg)"/>
  <ellipse cx="500" cy="860" rx="420" ry="90" fill="url(#floor)"/>
  <circle cx="790" cy="210" r="70" fill="#FFFFFF" opacity="0.55"/>
  <circle cx="210" cy="300" r="34" fill="#FFFFFF" opacity="0.45"/>
  <g transform="translate(200 120) scale(5)">${shadow}${bottle(kind, tint)}</g>
</svg>`;
}

/** Hover photo: a close-up of the formula's texture, in the product's own colour. */
export function textureSVG(tint: string, seed: number): string {
  const r = (n: number) => {
    const x = Math.sin(seed * 999 + n * 77.7) * 10000;
    return x - Math.floor(x);
  };
  const smears = Array.from({ length: 5 }, (_, i) => {
    const y = 180 + i * 150 + r(i) * 40;
    const amp = 60 + r(i + 10) * 70;
    return `<path d="M-60 ${y} C 220 ${y - amp}, 420 ${y + amp}, 620 ${y - amp / 2} S 960 ${y + amp}, 1080 ${y - 20}"
      fill="none" stroke="url(#cream)" stroke-width="${120 + r(i + 20) * 50}" stroke-linecap="round" opacity="${0.75 + r(i + 30) * 0.25}"/>
      <path d="M-60 ${y - 30} C 220 ${y - amp - 30}, 420 ${y + amp - 30}, 620 ${y - amp / 2 - 30} S 960 ${y + amp - 30}, 1080 ${y - 50}"
      fill="none" stroke="#FFFFFF" stroke-width="10" stroke-linecap="round" opacity="0.55"/>`;
  }).join("");
  const drops = Array.from({ length: 9 }, (_, i) => {
    const cx = 80 + r(i + 40) * 840;
    const cy = 80 + r(i + 50) * 840;
    const rad = 10 + r(i + 60) * 26;
    return `<circle cx="${cx}" cy="${cy}" r="${rad}" fill="url(#drop)"/><circle cx="${cx - rad / 3}" cy="${cy - rad / 3}" r="${rad / 4}" fill="#FFFFFF" opacity="0.85"/>`;
  }).join("");
  return `<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" viewBox="0 0 1000 1000">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#FFF3F7"/><stop offset="1" stop-color="${tint}" stop-opacity="0.55"/>
    </linearGradient>
    <linearGradient id="cream" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#FFFFFF" stop-opacity="0.9"/><stop offset="0.45" stop-color="${tint}"/><stop offset="1" stop-color="${tint}" stop-opacity="0.85"/>
    </linearGradient>
    <radialGradient id="drop" cx="40%" cy="35%" r="65%">
      <stop offset="0" stop-color="#FFFFFF"/><stop offset="1" stop-color="${tint}"/>
    </radialGradient>
  </defs>
  <rect width="1000" height="1000" fill="url(#bg)"/>
  ${smears}
  ${drops}
</svg>`;
}

/** Set photo: three of the set's products side by side. */
export function setSVG(items: { kind: ArtKind; tint: string }[]): string {
  const groups = items
    .slice(0, 3)
    .map((it, i) => {
      const x = [90, 360, 630][i];
      const y = i === 1 ? 170 : 230;
      return `<g transform="translate(${x} ${y}) scale(${i === 1 ? 4.2 : 3.7})">${shadow}${bottle(it.kind, it.tint)}</g>`;
    })
    .join("");
  return `<svg xmlns="http://www.w3.org/2000/svg" width="1000" height="1000" viewBox="0 0 1000 1000">
  <defs><radialGradient id="bg" cx="50%" cy="40%" r="75%"><stop offset="0" stop-color="#FFF7FA"/><stop offset="1" stop-color="#F5B9CC"/></radialGradient></defs>
  <rect width="1000" height="1000" fill="url(#bg)"/>
  <ellipse cx="500" cy="860" rx="460" ry="80" fill="#FFE9F0"/>
  ${groups}
</svg>`;
}
