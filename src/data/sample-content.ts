/**
 * SAMPLE CONTENT: every name, price, review, certification and claim in this
 * file is placeholder data for the template. Replace all of it with real,
 * verified information before launch. Nothing here describes a real product.
 */

export const BRAND = "Your Brand";

export const ANNOUNCEMENTS = [
  "Free shipping on orders over $40",
  "Buy any 2 routine steps, get 10% off",
  "Free sample with your first order",
];

export type ArtKind = "tube" | "jar" | "dropper" | "pump" | "pouch" | "stick";

export type Product = {
  id: string;
  name: string;
  type: string;
  size: string;
  price: number;
  art: ArtKind;
  tint: string;
  badge?: "New" | "Bestseller" | "Sale";
  blurb: string;
};

export const PRODUCTS: Product[] = [
  { id: "p-hydra", name: "Dew Barrier Essence", type: "Hydrating essence", size: "150 ml", price: 28, art: "pump", tint: "#F2A9C0", badge: "Bestseller", blurb: "A light, layerable essence that leaves skin plump and dewy." },
  { id: "p-barrier", name: "Ceramide Recovery Cream", type: "Barrier cream", size: "50 ml", price: 32, art: "jar", tint: "#F0A3BB", blurb: "A cushiony cream that comforts dry, stressed skin overnight." },
  { id: "p-soothe", name: "Centella Calming Serum", type: "Soothing serum", size: "30 ml", price: 26, art: "dropper", tint: "#E88CAB", badge: "Bestseller", blurb: "Calms visible redness and helps skin feel settled." },
  { id: "p-bright", name: "Rice Brightening Toner", type: "Brightening toner", size: "200 ml", price: 24, art: "pump", tint: "#EC96B1", badge: "New", blurb: "A silky toner for an even, luminous look." },
  { id: "p-pore", name: "Clay Pore Refining Mask", type: "Wash-off mask", size: "100 ml", price: 22, art: "tube", tint: "#E88FAD", blurb: "Lifts away excess oil and visibly tightens the look of pores." },
  { id: "p-blem", name: "Mugwort Spot Gel", type: "Blemish gel", size: "15 ml", price: 16, art: "stick", tint: "#F29DB9", blurb: "A targeted gel for breakout-prone areas." },
  { id: "p-exfo", name: "Gentle Enzyme Powder", type: "Exfoliating cleanser", size: "60 g", price: 20, art: "jar", tint: "#F2A6BE", badge: "New", blurb: "Daily smoothing without the sting." },
  { id: "p-firm", name: "Ginseng Lift Ampoule", type: "Firming ampoule", size: "30 ml", price: 38, art: "dropper", tint: "#D96F95", blurb: "A rich ampoule for bounce and a smoother-looking finish." },
  { id: "p-line", name: "Peptide Fine-Line Cream", type: "Anti-aging cream", size: "40 ml", price: 42, art: "jar", tint: "#EE9CB6", blurb: "Targets the look of fine lines around mouth and forehead." },
  { id: "p-sun", name: "Daily Light Sun Fluid SPF 50+", type: "Sunscreen", size: "50 ml", price: 18, art: "tube", tint: "#E98BAA", badge: "Bestseller", blurb: "A weightless, no-white-cast fluid for every day." },
  { id: "p-eye", name: "Green Tea Eye Stick", type: "Eye balm", size: "9 g", price: 21, art: "stick", tint: "#EC9AB6", blurb: "A cooling balm to refresh the eye area." },
  { id: "p-lip", name: "Honey Overnight Lip Mask", type: "Lip treatment", size: "20 g", price: 14, art: "pouch", tint: "#E57C9F", badge: "Sale", blurb: "A glossy overnight mask for soft, smooth lips." },
];

/** English source text; the storefront shows the translations in src/i18n/messages. */
export const TRUST = [
  "Dermatologist tested",
  "100% vegan formulas",
  "Cruelty-free",
  "Fragrance-free",
  "Paraben and sulphate free",
  "Made in Korea",
];

export type RoutineStep = { n: string; title: string; ko: string; note: string; productId: string };

export const ROUTINE: RoutineStep[] = [
  { n: "1", title: "Cleanse", ko: "세안", note: "Lift away oil and sunscreen without stripping.", productId: "p-exfo" },
  { n: "2", title: "Tone", ko: "토너", note: "Prep skin so everything after absorbs better.", productId: "p-bright" },
  { n: "3", title: "Treat", ko: "에센스", note: "One serum for the concern you care about most.", productId: "p-soothe" },
  { n: "4", title: "Moisturise", ko: "보습", note: "Seal it in with a cream suited to your skin.", productId: "p-barrier" },
  { n: "5", title: "Protect", ko: "선케어", note: "Finish every morning with broad-spectrum SPF.", productId: "p-sun" },
];

export type Ingredient = { ko: string; en: string; note: string };

export const INGREDIENTS: Ingredient[] = [
  { ko: "쑥", en: "Mugwort", note: "Traditionally used to calm blemish-prone, reactive skin." },
  { ko: "병풀", en: "Centella asiatica", note: "A K-beauty staple for soothing and comfort." },
  { ko: "쌀", en: "Rice", note: "Gentle, silky, and long loved for a bright-looking finish." },
  { ko: "녹차", en: "Green tea", note: "Rich in antioxidants; light, fresh, cooling." },
  { ko: "인삼", en: "Ginseng", note: "A heritage root for skin that looks firm and rested." },
  { ko: "꿀", en: "Honey", note: "A natural humectant for soft, cushioned skin." },
];

export type Review = { quote: string; name: string; skin: string; stars: number };

export const REVIEWS: Review[] = [
  { quote: "I stopped layering six things and started with the right two. My skin feels calm for the first time in months.", name: "Mina K.", skin: "Sensitive, dry", stars: 5 },
  { quote: "The essence feels like water and lasts all day under makeup.", name: "Aaliyah R.", skin: "Combination", stars: 5 },
  { quote: "Finally a sunscreen with no white cast that doesn't pill.", name: "Dev P.", skin: "Oily", stars: 4 },
];

export const SETS = [
  { id: "s-glow", name: "The Glow Routine", note: "Toner, serum, cream", save: "Save 15%", items: ["p-bright", "p-soothe", "p-barrier"] },
  { id: "s-calm", name: "The Calm Routine", note: "Essence, ampoule, SPF", save: "Save 12%", items: ["p-hydra", "p-firm", "p-sun"] },
];
