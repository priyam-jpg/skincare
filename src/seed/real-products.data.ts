/**
 * The client's real product range, read from the posters in /Products.
 * Prices are typical Swiss retail placeholders (set by the developer, to be confirmed by the client).
 * Sizes are only filled in where they are legible on the packaging; ingredients only where the poster names them.
 *
 * Crop rectangles are fractions of the poster: [left, top, right, bottom].
 * `blur` lists poster areas (badges, stickers) that are softened before cropping, so no poster text shows.
 */

export type L = { en: string; de: string; fr: string; it: string };
export type Rect = [number, number, number, number];
export type Shot = { poster: number; rect: Rect; blur?: Rect[]; trim?: boolean; /** Wide shots: fill the bottom margin with the top edge colour too. */ fillFromTop?: boolean };

export type ProductType =
  | "hairSerum" | "shampoo" | "hairTreatment" | "scalpScrub" | "scalpTonic"
  | "bodyWash" | "bodyScrubWash" | "bodyLotion"
  | "faceCream" | "gelCream"
  | "cleansingFoam" | "gelCleanser" | "cleansingBalm"
  | "toner" | "essence" | "tonerPads"
  | "serum" | "eyeSerum" | "sunscreen"
  | "sleepingMask" | "creamMask" | "sheetMask"
  | "lipEssence" | "lipMask" | "set";

export type RealProduct = {
  key: string;
  title: string;
  size?: string;
  type: ProductType;
  price: number; // CHF, incl. VAT
  badge?: "new" | "bestseller";
  /** Square product photos cut from the posters, in gallery order (first = main, second = hover). */
  shots: Shot[];
  /** Full posters added after the cut-outs (shown whole on the product page). */
  posters: number[];
  description: L;
  ingredients?: L;
  howToUse?: L;
};

export const CATEGORY_OF_TYPE: Record<ProductType, string> = {
  hairSerum: "hair", shampoo: "hair", hairTreatment: "hair", scalpScrub: "hair", scalpTonic: "hair",
  bodyWash: "body", bodyScrubWash: "body", bodyLotion: "body",
  faceCream: "moisturisers", gelCream: "moisturisers",
  cleansingFoam: "cleansers", gelCleanser: "cleansers", cleansingBalm: "cleansers",
  toner: "toners", essence: "toners", tonerPads: "toners",
  serum: "serums", eyeSerum: "serums", sunscreen: "suncare",
  sleepingMask: "treatments", creamMask: "treatments", sheetMask: "treatments",
  lipEssence: "lips", lipMask: "lips", set: "sets",
};

/** Categories added for the real range (the skincare ones already exist). */
export const NEW_CATEGORIES: Record<string, L> = {
  hair: { en: "Hair & scalp", de: "Haare & Kopfhaut", fr: "Cheveux & cuir chevelu", it: "Capelli & cuoio capelluto" },
  body: { en: "Body care", de: "Körperpflege", fr: "Soins du corps", it: "Cura del corpo" },
  lips: { en: "Lip care", de: "Lippenpflege", fr: "Soins des lèvres", it: "Cura delle labbra" },
};

export const TYPE_TEXT: Record<ProductType, { tagline: L; howToUse?: L }> = {
  hairSerum: {
    tagline: { en: "Hair serum", de: "Haarserum", fr: "Sérum capillaire", it: "Siero per capelli" },
    howToUse: {
      en: "Apply 1–2 pumps to towel-dried or dry lengths and ends, avoiding the scalp. Do not rinse.",
      de: "1–2 Pumpstösse in handtuchtrockene oder trockene Längen und Spitzen geben, Kopfhaut aussparen. Nicht ausspülen.",
      fr: "Appliquer 1 à 2 pressions sur les longueurs et pointes essorées ou sèches, sans toucher le cuir chevelu. Ne pas rincer.",
      it: "Applicare 1–2 erogazioni su lunghezze e punte tamponate o asciutte, evitando la cute. Non risciacquare.",
    },
  },
  shampoo: {
    tagline: { en: "Shampoo", de: "Shampoo", fr: "Shampooing", it: "Shampoo" },
    howToUse: {
      en: "Massage into wet hair and scalp, lather and rinse thoroughly.",
      de: "In das nasse Haar und die Kopfhaut einmassieren, aufschäumen und gründlich ausspülen.",
      fr: "Masser sur cheveux et cuir chevelu mouillés, faire mousser puis rincer abondamment.",
      it: "Massaggiare su capelli e cute bagnati, emulsionare e risciacquare accuratamente.",
    },
  },
  hairTreatment: {
    tagline: { en: "Hair treatment", de: "Haarkur", fr: "Soin capillaire", it: "Trattamento per capelli" },
    howToUse: {
      en: "After shampooing, apply to the lengths and ends, leave on for a few minutes and rinse.",
      de: "Nach dem Shampoo in Längen und Spitzen verteilen, einige Minuten einwirken lassen und ausspülen.",
      fr: "Après le shampooing, appliquer sur les longueurs et pointes, laisser poser quelques minutes puis rincer.",
      it: "Dopo lo shampoo applicare su lunghezze e punte, lasciare in posa qualche minuto e risciacquare.",
    },
  },
  scalpScrub: {
    tagline: { en: "Scalp scrub", de: "Kopfhautpeeling", fr: "Gommage du cuir chevelu", it: "Scrub per il cuoio capelluto" },
    howToUse: {
      en: "Before shampooing, massage gently into the wet scalp for 1–2 minutes and rinse. Use 1–2 times a week.",
      de: "Vor dem Shampoo 1–2 Minuten sanft in die nasse Kopfhaut einmassieren und ausspülen. 1–2 Mal pro Woche anwenden.",
      fr: "Avant le shampooing, masser délicatement le cuir chevelu mouillé pendant 1 à 2 minutes puis rincer. 1 à 2 fois par semaine.",
      it: "Prima dello shampoo massaggiare delicatamente la cute bagnata per 1–2 minuti e risciacquare. 1–2 volte a settimana.",
    },
  },
  scalpTonic: {
    tagline: { en: "Scalp tonic", de: "Kopfhaut-Tonikum", fr: "Tonique pour le cuir chevelu", it: "Tonico per il cuoio capelluto" },
    howToUse: {
      en: "Apply to the clean scalp, section by section, and massage in. Do not rinse. Use daily.",
      de: "Partienweise auf die saubere Kopfhaut auftragen und einmassieren. Nicht ausspülen. Täglich anwenden.",
      fr: "Appliquer mèche par mèche sur le cuir chevelu propre et masser. Ne pas rincer. Usage quotidien.",
      it: "Applicare a ciocche sulla cute pulita e massaggiare. Non risciacquare. Uso quotidiano.",
    },
  },
  bodyWash: {
    tagline: { en: "Body wash", de: "Duschgel", fr: "Gel douche", it: "Bagnoschiuma" },
    howToUse: {
      en: "Lather on wet skin and rinse.",
      de: "Auf der nassen Haut aufschäumen und abspülen.",
      fr: "Faire mousser sur peau mouillée puis rincer.",
      it: "Emulsionare sulla pelle bagnata e risciacquare.",
    },
  },
  bodyScrubWash: {
    tagline: { en: "Exfoliating body wash", de: "Peeling-Duschgel", fr: "Gel douche exfoliant", it: "Bagnoschiuma esfoliante" },
    howToUse: {
      en: "Massage onto wet skin in gentle circles and rinse. Use 2–3 times a week.",
      de: "Mit sanften, kreisenden Bewegungen auf der nassen Haut einmassieren und abspülen. 2–3 Mal pro Woche.",
      fr: "Masser la peau mouillée par mouvements circulaires doux puis rincer. 2 à 3 fois par semaine.",
      it: "Massaggiare la pelle bagnata con movimenti circolari delicati e risciacquare. 2–3 volte a settimana.",
    },
  },
  bodyLotion: {
    tagline: { en: "Body lotion", de: "Körperlotion", fr: "Lait corporel", it: "Lozione corpo" },
    howToUse: {
      en: "Apply generously to slightly damp skin after showering.",
      de: "Nach dem Duschen grosszügig auf die leicht feuchte Haut auftragen.",
      fr: "Appliquer généreusement sur la peau légèrement humide après la douche.",
      it: "Applicare generosamente sulla pelle leggermente umida dopo la doccia.",
    },
  },
  faceCream: {
    tagline: { en: "Face cream", de: "Gesichtscreme", fr: "Crème visage", it: "Crema viso" },
    howToUse: {
      en: "As the last step of your routine, morning and evening, smooth over face and neck.",
      de: "Als letzten Schritt der Routine morgens und abends auf Gesicht und Hals verteilen.",
      fr: "En dernière étape de la routine, matin et soir, appliquer sur le visage et le cou.",
      it: "Come ultimo passaggio della routine, mattina e sera, stendere su viso e collo.",
    },
  },
  gelCream: {
    tagline: { en: "Gel cream", de: "Gel-Creme", fr: "Gel-crème", it: "Gel crema" },
    howToUse: {
      en: "After cleansing and toning, smooth an even layer over face and neck, morning and evening.",
      de: "Nach Reinigung und Gesichtswasser morgens und abends gleichmässig auf Gesicht und Hals auftragen.",
      fr: "Après le nettoyage et la lotion, appliquer une couche uniforme sur le visage et le cou, matin et soir.",
      it: "Dopo detersione e tonico, stendere uno strato uniforme su viso e collo, mattina e sera.",
    },
  },
  cleansingFoam: {
    tagline: { en: "Cleansing foam", de: "Reinigungsschaum", fr: "Mousse nettoyante", it: "Schiuma detergente" },
    howToUse: {
      en: "Lather a small amount with water, massage over damp skin and rinse with lukewarm water.",
      de: "Eine kleine Menge mit Wasser aufschäumen, auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.",
      fr: "Faire mousser une petite quantité avec de l’eau, masser sur peau humide et rincer à l’eau tiède.",
      it: "Emulsionare una piccola quantità con acqua, massaggiare sulla pelle umida e risciacquare con acqua tiepida.",
    },
  },
  gelCleanser: {
    tagline: { en: "Gel cleanser", de: "Gel-Reiniger", fr: "Gel nettoyant", it: "Gel detergente" },
    howToUse: {
      en: "Massage a small amount over damp skin, morning and evening, and rinse with lukewarm water.",
      de: "Morgens und abends eine kleine Menge auf der feuchten Haut einmassieren und mit lauwarmem Wasser abspülen.",
      fr: "Matin et soir, masser une petite quantité sur peau humide et rincer à l’eau tiède.",
      it: "Mattina e sera massaggiare una piccola quantità sulla pelle umida e risciacquare con acqua tiepida.",
    },
  },
  cleansingBalm: {
    tagline: { en: "Cleansing balm", de: "Reinigungsbalsam", fr: "Baume démaquillant", it: "Balsamo detergente" },
    howToUse: {
      en: "Massage onto dry skin to dissolve make-up and sunscreen, add a little water to emulsify and rinse. Follow with a foam cleanser.",
      de: "Auf die trockene Haut einmassieren, um Make-up und Sonnenschutz zu lösen, mit etwas Wasser emulgieren und abspülen. Danach einen Schaumreiniger verwenden.",
      fr: "Masser sur peau sèche pour dissoudre maquillage et crème solaire, émulsionner avec un peu d’eau puis rincer. Poursuivre avec une mousse nettoyante.",
      it: "Massaggiare sulla pelle asciutta per sciogliere trucco e protezione solare, emulsionare con poca acqua e risciacquare. Proseguire con una schiuma detergente.",
    },
  },
  toner: {
    tagline: { en: "Toner", de: "Gesichtswasser", fr: "Lotion tonique", it: "Tonico" },
    howToUse: {
      en: "After cleansing, apply with your hands or a cotton pad and pat in gently.",
      de: "Nach der Reinigung mit den Händen oder einem Wattepad auftragen und sanft einklopfen.",
      fr: "Après le nettoyage, appliquer avec les mains ou un coton et faire pénétrer en tapotant.",
      it: "Dopo la detersione applicare con le mani o un dischetto e picchiettare delicatamente.",
    },
  },
  essence: {
    tagline: { en: "Essence", de: "Essenz", fr: "Essence", it: "Essenza" },
    howToUse: {
      en: "After toner, pat a few drops into the skin before serum and cream.",
      de: "Nach dem Gesichtswasser einige Tropfen in die Haut einklopfen, vor Serum und Creme.",
      fr: "Après la lotion, faire pénétrer quelques gouttes en tapotant, avant le sérum et la crème.",
      it: "Dopo il tonico picchiettare qualche goccia sulla pelle, prima di siero e crema.",
    },
  },
  tonerPads: {
    tagline: { en: "Toner pads", de: "Toner-Pads", fr: "Disques tonifiants", it: "Dischetti tonificanti" },
    howToUse: {
      en: "After cleansing, sweep a pad over the face and pat the remaining essence into the skin.",
      de: "Nach der Reinigung mit einem Pad über das Gesicht streichen und die restliche Essenz einklopfen.",
      fr: "Après le nettoyage, passer un disque sur le visage et faire pénétrer l’essence restante en tapotant.",
      it: "Dopo la detersione passare un dischetto sul viso e picchiettare l’essenza rimasta.",
    },
  },
  serum: {
    tagline: { en: "Serum", de: "Serum", fr: "Sérum", it: "Siero" },
    howToUse: {
      en: "After toner, apply 2–3 drops to the face and pat in before your cream.",
      de: "Nach dem Gesichtswasser 2–3 Tropfen auf das Gesicht geben und vor der Creme einklopfen.",
      fr: "Après la lotion, appliquer 2 à 3 gouttes sur le visage et tapoter avant la crème.",
      it: "Dopo il tonico applicare 2–3 gocce sul viso e picchiettare prima della crema.",
    },
  },
  eyeSerum: {
    tagline: { en: "Eye serum", de: "Augenserum", fr: "Sérum contour des yeux", it: "Siero contorno occhi" },
    howToUse: {
      en: "Morning and evening, tap a small amount gently around the eye area.",
      de: "Morgens und abends eine kleine Menge sanft um die Augenpartie einklopfen.",
      fr: "Matin et soir, tapoter délicatement une petite quantité sur le contour des yeux.",
      it: "Mattina e sera picchiettare delicatamente una piccola quantità sul contorno occhi.",
    },
  },
  sunscreen: {
    tagline: { en: "Sunscreen SPF 50+", de: "Sonnenschutz LSF 50+", fr: "Protection solaire SPF 50+", it: "Protezione solare SPF 50+" },
    howToUse: {
      en: "As the last step of your morning routine, apply evenly to face and neck. Reapply during long sun exposure.",
      de: "Als letzten Schritt der Morgenroutine gleichmässig auf Gesicht und Hals auftragen. Bei längerer Sonneneinstrahlung nachcremen.",
      fr: "En dernière étape de la routine du matin, appliquer uniformément sur le visage et le cou. Renouveler en cas d’exposition prolongée.",
      it: "Come ultimo passaggio della routine mattutina applicare uniformemente su viso e collo. Riapplicare in caso di esposizione prolungata.",
    },
  },
  sleepingMask: {
    tagline: { en: "Overnight mask", de: "Schlafmaske", fr: "Masque de nuit", it: "Maschera notte" },
    howToUse: {
      en: "As the last step of your evening routine, apply a thin layer and leave on overnight. Rinse in the morning.",
      de: "Als letzten Schritt der Abendroutine dünn auftragen und über Nacht einwirken lassen. Am Morgen abwaschen.",
      fr: "En dernière étape de la routine du soir, appliquer une fine couche et laisser agir toute la nuit. Rincer le matin.",
      it: "Come ultimo passaggio della routine serale applicare uno strato sottile e lasciare agire tutta la notte. Risciacquare al mattino.",
    },
  },
  creamMask: {
    tagline: { en: "Calming mask", de: "Beruhigende Maske", fr: "Masque apaisant", it: "Maschera lenitiva" },
    howToUse: {
      en: "Apply a generous layer to clean skin, leave on for 10–15 minutes and rinse. Use 2–3 times a week.",
      de: "Grosszügig auf die gereinigte Haut auftragen, 10–15 Minuten einwirken lassen und abspülen. 2–3 Mal pro Woche.",
      fr: "Appliquer une couche généreuse sur peau propre, laisser poser 10 à 15 minutes puis rincer. 2 à 3 fois par semaine.",
      it: "Applicare uno strato generoso sulla pelle pulita, lasciare in posa 10–15 minuti e risciacquare. 2–3 volte a settimana.",
    },
  },
  sheetMask: {
    tagline: { en: "Sheet mask, 1 piece", de: "Tuchmaske, 1 Stück", fr: "Masque en tissu, 1 pièce", it: "Maschera in tessuto, 1 pezzo" },
    howToUse: {
      en: "After toner, place the mask on the face for 15–20 minutes, remove and pat the remaining essence into the skin.",
      de: "Nach dem Gesichtswasser 15–20 Minuten auf das Gesicht legen, abnehmen und die restliche Essenz einklopfen.",
      fr: "Après la lotion, poser le masque 15 à 20 minutes, le retirer et faire pénétrer l’essence restante.",
      it: "Dopo il tonico applicare la maschera per 15–20 minuti, rimuoverla e picchiettare l’essenza rimasta.",
    },
  },
  lipEssence: {
    tagline: { en: "Lip essence", de: "Lippenessenz", fr: "Essence pour les lèvres", it: "Essenza labbra" },
    howToUse: {
      en: "Apply to the lips whenever they feel dry. Handy for on the go.",
      de: "Bei Bedarf auf die Lippen auftragen. Praktisch für unterwegs.",
      fr: "Appliquer sur les lèvres dès qu’elles tiraillent. Pratique à emporter.",
      it: "Applicare sulle labbra quando serve. Comoda da portare con sé.",
    },
  },
  lipMask: {
    tagline: { en: "Lip sleeping mask", de: "Lippen-Schlafmaske", fr: "Masque de nuit pour les lèvres", it: "Maschera notte labbra" },
    howToUse: {
      en: "Apply a generous layer before bed and leave on overnight. Can also be used during the day.",
      de: "Vor dem Schlafengehen grosszügig auftragen und über Nacht einwirken lassen. Auch tagsüber verwendbar.",
      fr: "Appliquer une couche généreuse avant le coucher et laisser agir toute la nuit. Utilisable aussi en journée.",
      it: "Applicare uno strato generoso prima di dormire e lasciare agire tutta la notte. Utilizzabile anche di giorno.",
    },
  },
  set: {
    tagline: { en: "Routine set", de: "Routine-Set", fr: "Coffret routine", it: "Set routine" },
  },
};

export const PRODUCTS: RealProduct[] = [
  // ───────────── Hair & scalp ─────────────
  {
    key: "mise-original", title: "Mise en Scène Perfect Serum Original", size: "80 ml", type: "hairSerum", price: 1490, badge: "new",
    shots: [{ poster: 1, rect: [0, 0.04, 0.46, 0.93] }], posters: [1],
    description: {
      en: "The cult Korean hair serum for smooth, glossy, healthy-looking hair without weighing it down. It adds intense shine, helps protect against heat, UV and everyday damage, and nourishes with a light, non-greasy formula.",
      de: "Das beliebte Haarserum aus Korea für glattes, glänzendes und gesund aussehendes Haar – ohne zu beschweren. Es verleiht intensiven Glanz, hilft vor Hitze, UV-Strahlen und äusseren Einflüssen zu schützen und pflegt mit einer leichten, nicht fettenden Formel.",
      fr: "Le sérum capillaire coréen culte pour des cheveux lisses, brillants et en pleine santé, sans les alourdir. Il apporte une brillance intense, aide à protéger de la chaleur, des UV et des agressions extérieures et nourrit grâce à une formule légère et non grasse.",
      it: "Il siero coreano di culto per capelli lisci, lucenti e dall’aspetto sano, senza appesantirli. Dona una brillantezza intensa, aiuta a proteggere da calore, raggi UV e agenti esterni e nutre con una formula leggera e non grassa.",
    },
  },
  {
    key: "mise-classic", title: "Mise en Scène Perfect Serum", type: "hairSerum", price: 1390, badge: "new",
    shots: [{ poster: 2, rect: [0, 0.08, 0.48, 0.905] }], posters: [2],
    description: {
      en: "The classic Korean hair serum for visibly smoother, glossier and healthier-looking hair. Gives instant shine and easy combing, helps protect against heat and UV, and helps reduce split ends with a fast-absorbing formula that never feels greasy.",
      de: "Das Kult-Haarserum aus Korea für sichtbar glatteres, glänzenderes und gesünder aussehendes Haar. Sorgt sofort für Glanz und leichte Kämmbarkeit, schützt vor Hitze und UV-Strahlen und hilft, Spliss zu reduzieren – mit einer schnell einziehenden Formel ohne fettiges Gefühl.",
      fr: "Le sérum capillaire coréen culte pour des cheveux visiblement plus lisses, plus brillants et en meilleure santé. Brillance immédiate et démêlage facile, protection contre la chaleur et les UV et moins de fourches, grâce à une formule qui pénètre vite sans effet gras.",
      it: "Il siero coreano di culto per capelli visibilmente più lisci, lucenti e sani. Brillantezza immediata e pettinabilità facile, protezione da calore e UV e meno doppie punte, con una formula che si assorbe in fretta senza ungere.",
    },
  },
  {
    key: "drforhair-folligen", title: "Dr.FORHAIR Folligen Original Shampoo", size: "500 ml", type: "shampoo", price: 2990, badge: "new",
    shots: [{ poster: 3, rect: [0, 0.08, 0.46, 0.92] }], posters: [3],
    description: {
      en: "A clinically tested shampoo for an oily, troubled scalp and thinning hair. Developed by the Dr.FORHAIR Scalp & Hair Research Center, it reduces excess sebum by up to 71.4 % and increases scalp strength by up to 40.2 %, with a gentle, paraben-free formula.",
      de: "Klinisch bewährte Pflege gegen übermässigen Talg und Kopfhautprobleme, ideal für dünner werdendes Haar. Entwickelt vom Dr.FORHAIR Scalp & Hair Research Center, reduziert überschüssigen Talg um bis zu 71,4 % und erhöht die Widerstandskraft der Kopfhaut um bis zu 40,2 % – sanft und frei von Parabenen.",
      fr: "Un shampooing cliniquement testé pour le cuir chevelu gras et sensible et les cheveux qui s’affinent. Développé par le Dr.FORHAIR Scalp & Hair Research Center, il réduit l’excès de sébum jusqu’à 71,4 % et renforce le cuir chevelu jusqu’à 40,2 %, avec une formule douce sans parabènes.",
      it: "Uno shampoo testato clinicamente per cute grassa e problematica e capelli che si diradano. Sviluppato dal Dr.FORHAIR Scalp & Hair Research Center, riduce il sebo in eccesso fino al 71,4 % e rafforza la cute fino al 40,2 %, con una formula delicata senza parabeni.",
    },
  },
  {
    key: "lador-lpp", title: "Lador Hydro LPP Treatment", size: "530 ml", type: "hairTreatment", price: 1990, badge: "new",
    shots: [{ poster: 4, rect: [0, 0.03, 0.47, 0.89] }], posters: [4],
    description: {
      en: "A professional salon treatment with low-molecular PPT that deeply repairs dry and damaged hair. Strengthens the hair from within, restores moisture and elasticity, and helps protect colour-treated hair, without silicones or parabens.",
      de: "Die professionelle Salonbehandlung mit niedrigmolekularem PPT versorgt trockenes und geschädigtes Haar tiefenwirksam mit Feuchtigkeit und Nährstoffen. Stärkt die Haarstruktur von innen, verbessert die Elastizität und schützt coloriertes Haar – silikon- und parabenfrei.",
      fr: "Un soin professionnel de salon au PPT de faible poids moléculaire qui répare en profondeur les cheveux secs et abîmés. Il renforce la fibre de l’intérieur, redonne hydratation et élasticité et protège les cheveux colorés, sans silicones ni parabènes.",
      it: "Un trattamento professionale da salone con PPT a basso peso molecolare che ripara in profondità i capelli secchi e danneggiati. Rinforza la fibra dall’interno, ridona idratazione ed elasticità e protegge i capelli colorati, senza siliconi né parabeni.",
    },
    ingredients: {
      en: "Low-molecular proteins (PPT) and collagen. Free from silicones and parabens.",
      de: "Niedrigmolekulare Proteine (PPT) und Kollagen. Frei von Silikonen und Parabenen.",
      fr: "Protéines de faible poids moléculaire (PPT) et collagène. Sans silicones ni parabènes.",
      it: "Proteine a basso peso molecolare (PPT) e collagene. Senza siliconi né parabeni.",
    },
  },
  {
    key: "aromatica-scrub", title: "Aromatica Rosemary Scalp Scrub", type: "scalpScrub", price: 2690, badge: "new",
    shots: [{ poster: 5, rect: [0, 0.05, 0.49, 0.86] }], posters: [5],
    description: {
      en: "A deep-cleansing scalp exfoliator with rosemary and sea salt. Gently removes dead skin cells and product build-up, leaves the scalp feeling fresh and clean, and supports healthy-looking hair growth. Vegan, without silicones.",
      de: "Tiefenreinigendes Peeling für die Kopfhaut mit Rosmarin und Meersalz. Entfernt sanft abgestorbene Hautzellen und Produktablagerungen, sorgt für ein frisches, belebtes Gefühl und fördert ein gesundes Haarwachstum. Vegan und ohne Silikone.",
      fr: "Un gommage purifiant du cuir chevelu au romarin et au sel marin. Il élimine en douceur cellules mortes et résidus de produits, laisse une sensation de fraîcheur et favorise une pousse saine. Vegan, sans silicones.",
      it: "Uno scrub purificante per la cute con rosmarino e sale marino. Rimuove delicatamente cellule morte e residui di prodotti, lascia una sensazione di freschezza e favorisce una crescita sana. Vegano, senza siliconi.",
    },
    ingredients: {
      en: "Rosemary extract, sea salt, plant-based exfoliating particles. Vegan, free from silicones.",
      de: "Rosmarin-Extrakt, Meersalz, pflanzliche Peeling-Partikel. Vegan, frei von Silikonen.",
      fr: "Extrait de romarin, sel marin, particules exfoliantes végétales. Vegan, sans silicones.",
      it: "Estratto di rosmarino, sale marino, particelle esfolianti vegetali. Vegano, senza siliconi.",
    },
  },
  {
    key: "aromatica-root", title: "Aromatica Rosemary Root Enhancer", size: "100 ml", type: "scalpTonic", price: 2490, badge: "new",
    shots: [{ poster: 6, rect: [0, 0.08, 0.48, 0.92] }], posters: [6],
    description: {
      en: "A scalp tonic with rosemary extract for stronger roots and fuller, healthier-looking hair. Revitalises the scalp, nourishes the hair roots to help prevent hair loss caused by breakage, and soothes a sensitive or irritated scalp.",
      de: "Kopfhaut-Tonikum mit Rosmarin-Extrakt für kräftigere Haarwurzeln und volleres, gesünder aussehendes Haar. Revitalisiert die Kopfhaut, nährt die Haarwurzeln, hilft Haarausfall durch Haarbruch vorzubeugen und beruhigt empfindliche Kopfhaut.",
      fr: "Un tonique pour le cuir chevelu à l’extrait de romarin pour des racines plus fortes et des cheveux plus denses. Il revitalise le cuir chevelu, nourrit les racines, aide à prévenir la chute liée à la casse et apaise le cuir chevelu sensible.",
      it: "Un tonico per la cute all’estratto di rosmarino per radici più forti e capelli più voluminosi. Rivitalizza la cute, nutre le radici, aiuta a prevenire la caduta dovuta alla rottura e lenisce la cute sensibile.",
    },
    ingredients: {
      en: "Rosemary extract. Vegan, free from silicones, parabens and artificial fragrance. Dermatologically tested.",
      de: "Rosmarin-Extrakt. Vegan, frei von Silikonen, Parabenen und künstlichen Duftstoffen. Dermatologisch getestet.",
      fr: "Extrait de romarin. Vegan, sans silicones, parabènes ni parfums artificiels. Testé dermatologiquement.",
      it: "Estratto di rosmarino. Vegano, senza siliconi, parabeni e profumi artificiali. Dermatologicamente testato.",
    },
  },
  {
    key: "aromatica-shampoo", title: "Aromatica Rosemary Scalp Scaling Shampoo", size: "400 ml", type: "shampoo", price: 2490, badge: "new",
    shots: [{ poster: 7, rect: [0, 0.05, 0.47, 0.95] }], posters: [7],
    description: {
      en: "A natural shampoo for a balanced scalp and stronger, shinier hair, every day. Rosemary extract revitalises the scalp while the deep-cleansing formula gently removes excess oil and residue for a fresh scalp, without silicones or sulfates.",
      de: "Natürliche Pflege für eine ausgeglichene Kopfhaut und gestärktes, glänzendes Haar – jeden Tag. Rosmarin-Extrakt revitalisiert die Kopfhaut, die tiefenreinigende Formel entfernt sanft überschüssiges Öl und Rückstände – frei von Silikonen und Sulfaten.",
      fr: "Un shampooing naturel pour un cuir chevelu équilibré et des cheveux plus forts et brillants, au quotidien. L’extrait de romarin revitalise le cuir chevelu et la formule purifiante élimine en douceur l’excès de sébum et les résidus, sans silicones ni sulfates.",
      it: "Uno shampoo naturale per una cute equilibrata e capelli più forti e lucenti, ogni giorno. L’estratto di rosmarino rivitalizza la cute e la formula purificante rimuove delicatamente sebo in eccesso e residui, senza siliconi né solfati.",
    },
    ingredients: {
      en: "Rosemary extract. Vegan, free from silicones and sulfates. Dermatologically tested.",
      de: "Rosmarin-Extrakt. Vegan, frei von Silikonen und Sulfaten. Dermatologisch getestet.",
      fr: "Extrait de romarin. Vegan, sans silicones ni sulfates. Testé dermatologiquement.",
      it: "Estratto di rosmarino. Vegano, senza siliconi né solfati. Dermatologicamente testato.",
    },
  },
  {
    key: "laboh-shampoo", title: "Labo-H Scalp Strengthening Shampoo", size: "750 ml", type: "shampoo", price: 2990,
    shots: [{ poster: 38, rect: [0.42, 0.19, 1, 0.97] }], posters: [38],
    description: {
      en: "A strengthening shampoo for a balanced scalp and stronger, healthier hair. It helps reinforce the scalp barrier and reduce hair loss, balances the scalp microbiome and cleanses gently while adding strength and vitality. Suitable for all hair types.",
      de: "Ein stärkendes Shampoo für eine ausgeglichene Kopfhaut und kräftigeres, gesünderes Haar. Hilft, die Barriere der Kopfhaut zu stärken und Haarausfall zu reduzieren, gleicht das Mikrobiom aus und reinigt sanft. Für alle Haartypen.",
      fr: "Un shampooing fortifiant pour un cuir chevelu équilibré et des cheveux plus forts et en pleine santé. Il aide à renforcer la barrière et à réduire la chute des cheveux, équilibre le microbiome et nettoie en douceur. Convient à tous les types de cheveux.",
      it: "Uno shampoo fortificante per una cute equilibrata e capelli più forti e sani. Aiuta a rafforzare la barriera e a ridurre la caduta dei capelli, riequilibra il microbioma e deterge delicatamente. Adatto a tutti i tipi di capelli.",
    },
    ingredients: {
      en: "Probiotics lysate, ceramide, PDRN, biotin and caffeine. Dermatologically tested.",
      de: "Probiotika-Lysat, Ceramid, PDRN, Biotin und Koffein. Dermatologisch getestet.",
      fr: "Lysat de probiotiques, céramide, PDRN, biotine et caféine. Testé dermatologiquement.",
      it: "Lisato di probiotici, ceramide, PDRN, biotina e caffeina. Dermatologicamente testato.",
    },
  },

  // ───────────── Body care (Illiyoon) ─────────────
  {
    key: "illiyoon-deep-moisture-wash", title: "Illiyoon Ultra Repair Deep Moisture Wash", size: "500 ml", type: "bodyWash", price: 1890,
    shots: [{ poster: 8, rect: [0.235, 0.52, 0.495, 0.93], blur: [[0.2, 0.54, 0.29, 0.635], [0.2, 0.635, 0.245, 0.93]] }], posters: [8],
    description: {
      en: "A gentle, moisture-giving body wash that cleanses without drying the skin out. Its ceramide and moisturising complex cares for dry and sensitive skin, and the pH-neutral formula suits the whole family.",
      de: "Feuchtigkeitsspendende Körperreinigung, die sanft reinigt, ohne die Haut auszutrocknen. Mit Ceramiden und Feuchtigkeitskomplex für trockene und empfindliche Haut, pH-hautneutral und für die ganze Familie geeignet.",
      fr: "Un gel douche doux et hydratant qui nettoie sans dessécher. Son complexe de céramides et d’agents hydratants prend soin des peaux sèches et sensibles, et sa formule au pH neutre convient à toute la famille.",
      it: "Un bagnoschiuma delicato e idratante che deterge senza seccare la pelle. Il complesso di ceramidi e agenti idratanti si prende cura della pelle secca e sensibile, e la formula a pH neutro è adatta a tutta la famiglia.",
    },
    ingredients: {
      en: "Ceramides and moisturising complex. pH-neutral.",
      de: "Ceramide und Feuchtigkeitskomplex. pH-hautneutral.",
      fr: "Céramides et complexe hydratant. pH neutre.",
      it: "Ceramidi e complesso idratante. pH neutro.",
    },
  },
  {
    key: "illiyoon-scrub-wash", title: "Illiyoon Ultra Moisture Scrub Wash", size: "500 ml", type: "bodyScrubWash", price: 1890,
    shots: [{ poster: 8, rect: [0.735, 0.52, 0.99, 0.93] }, { poster: 37, rect: [0, 0.3, 0.38, 0.91] }], posters: [8],
    description: {
      en: "A gentle exfoliating body wash for silky-smooth skin. Natural exfoliating particles remove dry, flaky skin softly while ceramides keep the skin moisturised. Suitable for sensitive and dry skin.",
      de: "Sanftes Peeling für geschmeidige Haut. Entfernt abgestorbene Hautschüppchen sanft, mit Ceramiden und natürlichem Peeling-Komplex, spendet Feuchtigkeit und pflegt. Für empfindliche und trockene Haut.",
      fr: "Un gel douche exfoliant doux pour une peau soyeuse. Des particules exfoliantes naturelles éliminent en douceur les peaux sèches et les squames, tandis que les céramides maintiennent l’hydratation. Convient aux peaux sensibles et sèches.",
      it: "Un bagnoschiuma esfoliante delicato per una pelle setosa. Particelle esfolianti naturali rimuovono delicatamente le pellicine secche, mentre le ceramidi mantengono la pelle idratata. Adatto a pelli sensibili e secche.",
    },
    ingredients: {
      en: "Ceramides and a natural exfoliating complex.",
      de: "Ceramide und natürlicher Peeling-Komplex.",
      fr: "Céramides et complexe exfoliant naturel.",
      it: "Ceramidi e complesso esfoliante naturale.",
    },
  },
  {
    key: "illiyoon-ato-lotion", title: "Illiyoon Ceramide Ato Lotion", size: "350 ml", type: "bodyLotion", price: 2290,
    shots: [{ poster: 8, rect: [0.725, 0.03, 0.99, 0.4] }, { poster: 37, rect: [0.36, 0.3, 0.63, 0.91] }], posters: [8],
    description: {
      en: "A light daily moisturising lotion with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It absorbs quickly without feeling sticky and keeps sensitive and dry skin moisturised for 24 hours. Fragrance-free and hypoallergenic.",
      de: "Leichte, tägliche Feuchtigkeitspflege mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Zieht schnell ein, klebt nicht und spendet 24 Stunden Feuchtigkeit für empfindliche und trockene Haut. Parfümfrei und hypoallergen.",
      fr: "Un lait hydratant léger au quotidien, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Il pénètre vite sans coller et hydrate 24 heures les peaux sensibles et sèches. Sans parfum et hypoallergénique.",
      it: "Una lozione idratante leggera per tutti i giorni, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Si assorbe in fretta senza appiccicare e idrata per 24 ore la pelle sensibile e secca. Senza profumo e ipoallergenica.",
    },
    ingredients: {
      en: "Ceramide Skin Complex™. Fragrance-free, hypoallergenic.",
      de: "Ceramide Skin Complex™. Parfümfrei, hypoallergen.",
      fr: "Ceramide Skin Complex™. Sans parfum, hypoallergénique.",
      it: "Ceramide Skin Complex™. Senza profumo, ipoallergenica.",
    },
  },
  {
    key: "illiyoon-top-to-toe", title: "Illiyoon Ceramide Ato 6.0 Top to Toe Wash", type: "bodyWash", price: 1990,
    shots: [{ poster: 37, rect: [0.6, 0.3, 0.96, 0.91] }], posters: [37],
    description: {
      en: "A mild, fragrance-free wash for hair and body, made for the whole family, including sensitive skin. Ceramides help strengthen the skin barrier while it cleanses gently and keeps skin hydrated. Dermatologically tested, made in Korea.",
      de: "Eine milde, parfümfreie Wäsche für Haar und Körper, für die ganze Familie und auch für empfindliche Haut. Ceramide stärken die Hautbarriere, während sie sanft reinigt und Feuchtigkeit spendet. Dermatologisch getestet, hergestellt in Korea.",
      fr: "Un nettoyant doux sans parfum pour les cheveux et le corps, pour toute la famille, y compris les peaux sensibles. Les céramides renforcent la barrière cutanée tout en nettoyant en douceur et en hydratant. Testé dermatologiquement, fabriqué en Corée.",
      it: "Un detergente delicato senza profumo per capelli e corpo, per tutta la famiglia e anche per pelli sensibili. Le ceramidi rafforzano la barriera cutanea mentre deterge delicatamente e idrata. Dermatologicamente testato, prodotto in Corea.",
    },
    ingredients: {
      en: "Ceramides. No added fragrance.",
      de: "Ceramide. Ohne zugesetztes Parfüm.",
      fr: "Céramides. Sans parfum ajouté.",
      it: "Ceramidi. Senza profumo aggiunto.",
    },
  },

  // ───────────── Moisturisers ─────────────
  {
    key: "illiyoon-ato-cream", title: "Illiyoon Ceramide Ato Concentrate Cream", size: "75 ml", type: "faceCream", price: 1690,
    shots: [{ poster: 8, rect: [0.25, 0.03, 0.49, 0.4] }], posters: [8],
    description: {
      en: "An intensive cream for sensitive skin with Illiyoon’s Ceramide Skin Complex to strengthen the skin barrier. It gives long-lasting moisture and suits dry and sensitive skin on face and body. Fragrance-free and gentle.",
      de: "Intensive Feuchtigkeit für empfindliche Haut, mit Ceramide Skin Complex™ zur Stärkung der Hautbarriere. Spendet langanhaltende Feuchtigkeit, ideal für trockene und empfindliche Haut. Parfümfrei und sanft.",
      fr: "Une crème intensive pour peaux sensibles, avec le Ceramide Skin Complex™ d’Illiyoon pour renforcer la barrière cutanée. Elle hydrate durablement les peaux sèches et sensibles du visage et du corps. Sans parfum et douce.",
      it: "Una crema intensiva per pelli sensibili, con il Ceramide Skin Complex™ di Illiyoon per rafforzare la barriera cutanea. Idrata a lungo la pelle secca e sensibile di viso e corpo. Senza profumo e delicata.",
    },
    ingredients: {
      en: "Ceramide Skin Complex™. Fragrance-free.",
      de: "Ceramide Skin Complex™. Parfümfrei.",
      fr: "Ceramide Skin Complex™. Sans parfum.",
      it: "Ceramide Skin Complex™. Senza profumo.",
    },
  },
  {
    key: "dr-althea-345", title: "Dr. Althea 345 Relief Cream", type: "faceCream", price: 2990, badge: "bestseller",
    shots: [{ poster: 10, rect: [0, 0.14, 0.45, 0.93] }, { poster: 18, rect: [0.46, 0.1, 1, 0.99], blur: [[0.85, 0, 1, 0.21], [0.44, 0.07, 0.64, 0.14]] }], posters: [10, 18],
    description: {
      en: "A multi-tasking cream with the 3-4-5 formula: three key ingredients to soothe, four to care and five to protect. It calms irritation and redness, strengthens the skin barrier and supports regeneration with a light, non-sticky texture. For all skin types, including sensitive skin.",
      de: "Die multifunktionale Creme mit der 3-4-5 Formel: drei Schlüsselwirkstoffe für Beruhigung, vier für Pflege und fünf für Schutz. Beruhigt Irritationen und Rötungen, stärkt die Hautbarriere und fördert die Regeneration – leicht und nicht klebend. Für alle Hauttypen, auch für empfindliche Haut.",
      fr: "Une crème multifonction à la formule 3-4-5 : trois actifs pour apaiser, quatre pour soigner et cinq pour protéger. Elle calme irritations et rougeurs, renforce la barrière cutanée et favorise la régénération, avec une texture légère et non collante. Pour tous les types de peau, même sensibles.",
      it: "Una crema multifunzione con la formula 3-4-5: tre attivi per lenire, quattro per curare e cinque per proteggere. Calma irritazioni e rossori, rafforza la barriera cutanea e favorisce la rigenerazione con una texture leggera e non appiccicosa. Per tutti i tipi di pelle, anche sensibile.",
    },
    ingredients: {
      en: "Niacinamide, centella asiatica, madecassoside, ceramide NP, panthenol, hyaluronic acid, beta-glucan and plant extracts. Free from artificial fragrance, parabens and mineral oils.",
      de: "Niacinamid, Centella Asiatica, Madecassoside, Ceramid NP, Panthenol, Hyaluronsäure, Beta-Glucan und Pflanzenextrakte. Frei von künstlichen Duftstoffen, Parabenen und Mineralölen.",
      fr: "Niacinamide, centella asiatica, madécassoside, céramide NP, panthénol, acide hyaluronique, bêta-glucane et extraits de plantes. Sans parfum artificiel, parabènes ni huiles minérales.",
      it: "Niacinamide, centella asiatica, madecassoside, ceramide NP, pantenolo, acido ialuronico, beta-glucano ed estratti vegetali. Senza profumi artificiali, parabeni e oli minerali.",
    },
  },
  {
    key: "purito-oat-gel-cream", title: "Purito Oat-In Calming Gel Cream", size: "100 ml", type: "gelCream", price: 2390,
    shots: [{ poster: 15, rect: [0.505, 0.04, 0.8, 0.87] }], posters: [15],
    description: {
      en: "A soothing gel cream with oat water and oat extract that gives intense, long-lasting moisture. It calms irritation and redness, leaves a refreshing, cooling feel and strengthens the skin barrier. Light, non-sticky texture for sensitive, irritated and dry skin.",
      de: "Die beruhigende Gel-Creme mit Haferwasser und Haferextrakt spendet intensive Feuchtigkeit, mildert Rötungen und stärkt die natürliche Schutzbarriere. Kühlt angenehm, zieht schnell ein und klebt nicht. Ideal für empfindliche, gereizte und trockene Haut.",
      fr: "Un gel-crème apaisant à l’eau et à l’extrait d’avoine qui hydrate intensément et durablement. Il calme irritations et rougeurs, procure une sensation de fraîcheur et renforce la barrière cutanée. Texture légère et non collante pour peaux sensibles, irritées et sèches.",
      it: "Un gel crema lenitivo con acqua e estratto d’avena che idrata intensamente e a lungo. Calma irritazioni e rossori, rinfresca e rafforza la barriera cutanea. Texture leggera e non appiccicosa per pelli sensibili, irritate e secche.",
    },
    ingredients: {
      en: "Oat seed water, oat extract and squalane. Free from parabens, silicones, mineral oils and artificial colours.",
      de: "Haferwasser, Haferextrakt und Squalan. Frei von Parabenen, Silikonen, Mineralölen und künstlichen Farbstoffen.",
      fr: "Eau d’avoine, extrait d’avoine et squalane. Sans parabènes, silicones, huiles minérales ni colorants artificiels.",
      it: "Acqua d’avena, estratto d’avena e squalano. Senza parabeni, siliconi, oli minerali e coloranti artificiali.",
    },
  },
  {
    key: "cosrx-snail-92-cream", title: "COSRX Advanced Snail 92 All in One Cream", size: "100 g", type: "faceCream", price: 2490,
    shots: [{ poster: 24, rect: [0.42, 0.29, 1, 0.82] }], posters: [24],
    description: {
      en: "A daily all-in-one cream with 92 % snail secretion filtrate for healthy, radiant skin. It gives intense moisture, supports regeneration and strengthens the skin barrier, with a light texture that absorbs quickly. Suitable for all skin types.",
      de: "Tägliche Pflege für gesunde, strahlende Haut mit 92 % Schneckensekret-Filtrat. Spendet intensive Feuchtigkeit, unterstützt die Regeneration und stärkt die Hautbarriere – mit leichter Textur, die schnell einzieht. Für alle Hauttypen.",
      fr: "Une crème tout-en-un au quotidien avec 92 % de filtrat de bave d’escargot pour une peau saine et lumineuse. Elle hydrate intensément, soutient la régénération et renforce la barrière cutanée, avec une texture légère qui pénètre vite. Pour tous les types de peau.",
      it: "Una crema tutto-in-uno quotidiana con il 92 % di filtrato di bava di lumaca per una pelle sana e luminosa. Idrata intensamente, sostiene la rigenerazione e rafforza la barriera cutanea con una texture leggera che si assorbe in fretta. Per tutti i tipi di pelle.",
    },
    ingredients: {
      en: "92 % snail secretion filtrate (mucin).",
      de: "92 % Schneckensekret-Filtrat (Mucin).",
      fr: "92 % de filtrat de bave d’escargot (mucine).",
      it: "92 % di filtrato di bava di lumaca (mucina).",
    },
  },
  {
    key: "somebymi-snail-truecica", title: "Some By Mi Snail Truecica Miracle Repair Cream", size: "60 g", type: "faceCream", price: 2490,
    shots: [{ poster: 26, rect: [0, 0.35, 1, 0.86], blur: [[0.78, 0.33, 1, 0.43]] }], posters: [26],
    description: {
      en: "A regenerating and protective cream for healthy, radiant skin. 42 % Snail Truecica™ repairs damaged skin and gives intense moisture, while five types of ceramides strengthen the skin barrier. Dermatologically tested and suitable for sensitive skin.",
      de: "Regeneration und Schutz für eine gesunde, strahlende Haut. 42 % Snail Truecica™ regeneriert und spendet Feuchtigkeit, fünf Arten von Ceramiden stärken die Hautbarriere. Leichte Textur, zieht schnell ein. Dermatologisch getestet und für empfindliche Haut geeignet.",
      fr: "Une crème régénérante et protectrice pour une peau saine et lumineuse. 42 % de Snail Truecica™ répare et hydrate intensément, tandis que cinq types de céramides renforcent la barrière cutanée. Testée dermatologiquement, convient aux peaux sensibles.",
      it: "Una crema rigenerante e protettiva per una pelle sana e luminosa. Il 42 % di Snail Truecica™ ripara e idrata intensamente, mentre cinque tipi di ceramidi rafforzano la barriera cutanea. Dermatologicamente testata, adatta alle pelli sensibili.",
    },
    ingredients: {
      en: "42 % Snail Truecica™ and 5 types of ceramides.",
      de: "42 % Snail Truecica™ und 5 Arten von Ceramiden.",
      fr: "42 % de Snail Truecica™ et 5 types de céramides.",
      it: "42 % di Snail Truecica™ e 5 tipi di ceramidi.",
    },
  },

  // ───────────── Cleansers ─────────────
  {
    key: "roundlab-mugwort-foam", title: "Round Lab Mugwort Cleansing Foam", size: "150 ml", type: "cleansingFoam", price: 1890,
    shots: [{ poster: 14, rect: [0.58, 0.11, 0.85, 0.87] }], posters: [14],
    description: {
      en: "A gentle cleansing foam with mugwort extract that cleanses deeply while calming sensitive skin. Its dense foam removes impurities, excess oil and make-up residue without drying, and supports the natural protective barrier. For all skin types, especially sensitive and blemish-prone skin.",
      de: "Sanfte Reinigung, die beruhigt und schützt. Der Reinigungsschaum mit Beifussextrakt reinigt porentief, entfernt Unreinheiten, überschüssigen Talg und Make-up-Reste, ohne auszutrocknen, und stärkt die natürliche Schutzbarriere. Für alle Hauttypen, besonders für empfindliche und zu Unreinheiten neigende Haut.",
      fr: "Une mousse nettoyante douce à l’extrait d’armoise qui nettoie en profondeur tout en apaisant. Sa mousse dense élimine impuretés, excès de sébum et résidus de maquillage sans dessécher et soutient la barrière naturelle. Pour tous les types de peau, en particulier sensibles et à imperfections.",
      it: "Una schiuma detergente delicata all’estratto di artemisia che pulisce in profondità e lenisce. La schiuma densa rimuove impurità, sebo in eccesso e residui di trucco senza seccare e sostiene la barriera naturale. Per tutti i tipi di pelle, soprattutto sensibili e con imperfezioni.",
    },
    ingredients: {
      en: "Mugwort extract. Free from parabens, silicones, mineral oils, artificial colours and PEGs.",
      de: "Beifussextrakt. Frei von Parabenen, Silikonen, Mineralölen, künstlichen Farbstoffen und PEGs.",
      fr: "Extrait d’armoise. Sans parabènes, silicones, huiles minérales, colorants artificiels ni PEG.",
      it: "Estratto di artemisia. Senza parabeni, siliconi, oli minerali, coloranti artificiali e PEG.",
    },
  },
  {
    key: "cosrx-low-ph-cleanser", title: "COSRX Low pH Good Morning Gel Cleanser", size: "150 ml", type: "gelCleanser", price: 1390, badge: "bestseller",
    shots: [{ poster: 19, rect: [0.47, 0.04, 1, 0.99], blur: [[0.78, 0, 1, 0.2]] }], posters: [19],
    description: {
      en: "A mild, low-pH gel cleanser for a fresh start to the day. With a pH of about 5.0 it cleanses thoroughly without drying, respects the skin’s natural barrier and removes excess oil and impurities. Tea tree oil and botanical extracts keep skin calm and clear.",
      de: "Sanfte Reinigung für einen frischen Start in den Tag. Mit einem pH-Wert von ca. 5,0 reinigt der Gel-Reiniger gründlich, ohne auszutrocknen, bewahrt die natürliche Schutzbarriere und entfernt Talg und Unreinheiten. Teebaumöl und botanische Extrakte sorgen für eine ruhige, klare Haut.",
      fr: "Un gel nettoyant doux au pH bas pour bien commencer la journée. Avec un pH d’environ 5,0, il nettoie en profondeur sans dessécher, respecte la barrière naturelle et élimine sébum et impuretés. L’huile d’arbre à thé et des extraits botaniques gardent la peau calme et nette.",
      it: "Un gel detergente delicato a pH basso per iniziare bene la giornata. Con un pH di circa 5,0 deterge a fondo senza seccare, rispetta la barriera naturale e rimuove sebo e impurità. Olio di tea tree ed estratti botanici mantengono la pelle calma e pulita.",
    },
    ingredients: {
      en: "Tea tree oil and botanical extracts, pH about 5.0. Free from parabens, silicones, artificial colours and mineral oils.",
      de: "Teebaumöl und botanische Extrakte, pH-Wert ca. 5,0. Frei von Parabenen, Silikonen, künstlichen Farbstoffen und Mineralölen.",
      fr: "Huile d’arbre à thé et extraits botaniques, pH d’environ 5,0. Sans parabènes, silicones, colorants artificiels ni huiles minérales.",
      it: "Olio di tea tree ed estratti botanici, pH circa 5,0. Senza parabeni, siliconi, coloranti artificiali e oli minerali.",
    },
  },
  {
    key: "lagom-microfoam", title: "Lagom Cellup Micro Foam Cleanser", size: "120 ml", type: "cleansingFoam", price: 2290,
    shots: [{ poster: 23, rect: [0, 0.19, 0.34, 0.73] }], posters: [23],
    description: {
      en: "A gentle micro-foam cleanser for beautifully clear skin. Its fine foam cleanses pores and removes dirt and excess oil, while the pH-neutral formula keeps skin moisturised and balanced. Gentle enough for daily use, even on sensitive skin.",
      de: "Sanfte Reinigung für strahlend schöne Haut. Die Mikro-Schaum-Technologie reinigt porentief und entfernt Schmutz und überschüssiges Öl, die pH-hautneutrale Formel bewahrt die natürliche Feuchtigkeitsbalance. Täglich anwendbar, auch bei sensibler Haut.",
      fr: "Une mousse micro-bulles douce pour une peau nette et lumineuse. Sa mousse fine nettoie les pores et élimine impuretés et excès de sébum, tandis que la formule au pH neutre préserve l’hydratation. Assez douce pour un usage quotidien, même sur peau sensible.",
      it: "Una schiuma a micro-bolle delicata per una pelle pulita e luminosa. La schiuma fine pulisce i pori e rimuove impurità e sebo in eccesso, mentre la formula a pH neutro preserva l’idratazione. Delicata per l’uso quotidiano, anche su pelle sensibile.",
    },
    ingredients: {
      en: "Plant-based surfactants and moisturising agents. pH-neutral.",
      de: "Pflanzliche Tenside und Feuchtigkeitsspender. pH-hautneutral.",
      fr: "Tensioactifs végétaux et agents hydratants. pH neutre.",
      it: "Tensioattivi vegetali e agenti idratanti. pH neutro.",
    },
  },
  {
    key: "bplain-mungbean-foam", title: "b:plain Mung Bean Cleansing Foam", type: "cleansingFoam", price: 1990,
    shots: [{ poster: 30, rect: [0.48, 0.19, 0.985, 0.86], blur: [[0.82, 0, 1, 0.2]] }], posters: [30],
    description: {
      en: "A gentle cleansing foam powered by mung bean for a natural glow every day. It removes dirt and excess oil softly, leaves skin fresher and brighter, and keeps moisture in without a tight feeling. Suitable for all skin types, including sensitive skin.",
      de: "Sanfte Reinigung mit der Kraft der Mungbohne – für einen natürlichen Glow jeden Tag. Entfernt Schmutz und Überschuss sanft, sorgt für reinere, strahlendere Haut und bewahrt die Feuchtigkeit ohne Spannungsgefühl. Für alle Hauttypen, auch für empfindliche Haut.",
      fr: "Une mousse nettoyante douce à la puissance du haricot mungo pour un éclat naturel au quotidien. Elle élimine en douceur impuretés et excès de sébum, rend la peau plus nette et lumineuse et préserve l’hydratation sans tiraillement. Pour tous les types de peau, même sensibles.",
      it: "Una schiuma detergente delicata con la forza del fagiolo mungo per un glow naturale ogni giorno. Rimuove delicatamente impurità e sebo in eccesso, rende la pelle più pulita e luminosa e preserva l’idratazione senza tirare. Per tutti i tipi di pelle, anche sensibili.",
    },
    ingredients: {
      en: "Mung bean extract. Vegan, free from parabens, sulfates and artificial fragrance.",
      de: "Mungbohnen-Extrakt. Vegan, frei von Parabenen, Sulfaten und künstlichen Duftstoffen.",
      fr: "Extrait de haricot mungo. Vegan, sans parabènes, sulfates ni parfums artificiels.",
      it: "Estratto di fagiolo mungo. Vegano, senza parabeni, solfati e profumi artificiali.",
    },
  },
  {
    key: "jipu-cleansing-balm", title: "JIPU Cleansing Balm", size: "30 ml", type: "cleansingBalm", price: 1290, badge: "new",
    shots: [{ poster: 31, rect: [0.44, 0.26, 1, 0.8], blur: [[0.8, 0.14, 1, 0.25]] }], posters: [31],
    description: {
      en: "A hydrating cleansing balm that effectively removes make-up, sunscreen, dirt and excess oil for clean, fresh skin. The soft balm melts on contact and rinses off easily, cleanses pores and leaves skin supple. Vegan and dermatologically tested, suitable for sensitive skin.",
      de: "Der JIPU Cleansing Balm entfernt effektiv Make-up, Schmutz und überschüssiges Öl – für eine saubere, gepflegte und frische Haut. Die angenehme Balm-Textur löst sich leicht auf und lässt sich einfach abwaschen, reinigt die Poren und spendet Feuchtigkeit. Vegan, dermatologisch getestet und für empfindliche Haut geeignet.",
      fr: "Un baume démaquillant hydratant qui élimine efficacement maquillage, crème solaire, impuretés et excès de sébum pour une peau nette et fraîche. Le baume fondant se rince facilement, nettoie les pores et laisse la peau souple. Vegan et testé dermatologiquement, convient aux peaux sensibles.",
      it: "Un balsamo detergente idratante che rimuove efficacemente trucco, protezione solare, impurità e sebo in eccesso per una pelle pulita e fresca. Il balsamo si scioglie a contatto e si risciacqua facilmente, pulisce i pori e lascia la pelle morbida. Vegano e dermatologicamente testato, adatto alle pelli sensibili.",
    },
  },
  {
    key: "innisfree-amino-foam", title: "Innisfree Green Tea Amino Hydrating Cleansing Foam", size: "150 g", type: "cleansingFoam", price: 1490,
    shots: [{ poster: 36, rect: [0.36, 0.22, 1, 0.91] }], posters: [36],
    description: {
      en: "A gentle hydrating cleansing foam with green tea and amino acids. It cleanses softly while keeping skin supple and comfortable, and removes impurities and excess oil for a fresh, luminous complexion. Suitable for all skin types.",
      de: "Ein sanfter, feuchtigkeitsspendender Reinigungsschaum mit Grüntee und Aminosäuren. Reinigt mild und hält die Haut geschmeidig und angenehm, entfernt Unreinheiten und überschüssigen Talg für einen frischen, strahlenden Teint. Für alle Hauttypen.",
      fr: "Une mousse nettoyante hydratante au thé vert et aux acides aminés. Elle nettoie en douceur tout en gardant la peau souple et confortable, et élimine impuretés et excès de sébum pour un teint frais et lumineux. Pour tous les types de peau.",
      it: "Una schiuma detergente idratante al tè verde e aminoacidi. Deterge delicatamente mantenendo la pelle morbida e confortevole e rimuove impurità e sebo in eccesso per un incarnato fresco e luminoso. Per tutti i tipi di pelle.",
    },
    ingredients: {
      en: "Green tea and amino acids. Free from parabens and mineral oils.",
      de: "Grüntee und Aminosäuren. Frei von Parabenen und Mineralölen.",
      fr: "Thé vert et acides aminés. Sans parabènes ni huiles minérales.",
      it: "Tè verde e aminoacidi. Senza parabeni e oli minerali.",
    },
  },

  // ───────────── Toners & essences ─────────────
  {
    key: "mixsoon-bean-essence", title: "Mixsoon Bean Essence", size: "50 ml", type: "essence", price: 2990,
    shots: [{ poster: 17, rect: [0.5, 0.1, 0.8, 0.95] }], posters: [17],
    description: {
      en: "A pure essence made from 100 % fermented soybean extract. It gives long-lasting moisture, refines and evens the skin tone for a natural glow, and strengthens the skin barrier. Minimal and effective, for sensitive, dry and irritated skin.",
      de: "Die Bean Essence von mixsoon besteht aus 100 % fermentiertem Sojabohnenextrakt. Sie spendet intensive Feuchtigkeit, verbessert den Hautton und stärkt die Hautbarriere – für eine gesunde, strahlende Haut. Minimal und effektiv, besonders für empfindliche, trockene und gereizte Haut.",
      fr: "Une essence pure composée à 100 % d’extrait de soja fermenté. Elle hydrate durablement, affine et unifie le teint pour un éclat naturel et renforce la barrière cutanée. Minimaliste et efficace, pour peaux sensibles, sèches et irritées.",
      it: "Un’essenza pura composta al 100 % da estratto di soia fermentato. Idrata a lungo, affina e uniforma l’incarnato per un glow naturale e rafforza la barriera cutanea. Minimalista ed efficace, per pelli sensibili, secche e irritate.",
    },
    ingredients: {
      en: "100 % fermented soybean extract. No additives, colours or essential oils.",
      de: "100 % fermentierter Sojabohnenextrakt. Ohne Zusatzstoffe, Farbstoffe und ätherische Öle.",
      fr: "100 % d’extrait de soja fermenté. Sans additifs, colorants ni huiles essentielles.",
      it: "100 % estratto di soia fermentato. Senza additivi, coloranti e oli essenziali.",
    },
  },
  {
    key: "anua-heartleaf-77", title: "Anua Heartleaf 77% Soothing Toner", size: "250 ml", type: "toner", price: 2490, badge: "bestseller",
    shots: [{ poster: 20, rect: [0.56, 0.13, 1, 0.99], blur: [[0.85, 0, 1, 0.17]] }], posters: [20],
    description: {
      en: "A mild, soothing toner with 77 % heartleaf extract and hyaluronic acid for healthy, hydrated skin. It calms sensitive skin and redness, gives long-lasting moisture and strengthens the skin barrier, with a light texture that absorbs quickly. For sensitive, dry and irritated skin.",
      de: "Beruhigender Toner für gesunde, hydrierte Haut. Die milde Formel mit 77 % Herzblatt-Extrakt und Hyaluronsäure spendet intensiv Feuchtigkeit, beruhigt gereizte Haut und stärkt die Hautbarriere. Leichte Textur, zieht schnell ein. Besonders für empfindliche, trockene und gereizte Haut.",
      fr: "Une lotion tonique douce et apaisante à 77 % d’extrait de houttuynia et acide hyaluronique pour une peau saine et hydratée. Elle calme les peaux sensibles et les rougeurs, hydrate durablement et renforce la barrière cutanée, avec une texture légère. Pour peaux sensibles, sèches et irritées.",
      it: "Un tonico delicato e lenitivo con il 77 % di estratto di houttuynia e acido ialuronico per una pelle sana e idratata. Calma pelli sensibili e rossori, idrata a lungo e rafforza la barriera cutanea, con una texture leggera. Per pelli sensibili, secche e irritate.",
    },
    ingredients: {
      en: "77 % heartleaf (houttuynia cordata) extract and hyaluronic acid. Free from parabens, alcohol and fragrance.",
      de: "77 % Herzblatt-Extrakt (Houttuynia Cordata) und Hyaluronsäure. Frei von Parabenen, Alkohol und Duftstoffen.",
      fr: "77 % d’extrait de houttuynia cordata et acide hyaluronique. Sans parabènes, alcool ni parfum.",
      it: "77 % di estratto di houttuynia cordata e acido ialuronico. Senza parabeni, alcol e profumo.",
    },
  },
  {
    key: "cosrx-snail-96-essence", title: "COSRX Advanced Snail 96 Mucin Power Essence", size: "100 ml", type: "essence", price: 2490, badge: "bestseller",
    shots: [{ poster: 21, rect: [0.47, 0.04, 1, 0.99], blur: [[0.79, 0, 1, 0.19]] }], posters: [21],
    description: {
      en: "A light essence with 96 % snail secretion filtrate that repairs, hydrates and regenerates. It strengthens the skin barrier, plumps the skin with long-lasting moisture and refines the skin texture, while calming blemishes and redness. Especially good for dry and damaged skin.",
      de: "Diese leichte Essence mit 96 % Schneckenschleimfiltrat versorgt die Haut intensiv mit Feuchtigkeit, unterstützt die Regeneration und verleiht ein gesundes, strahlendes Hautbild. Repariert die Hautbarriere, verbessert die Hauttextur und mildert Unreinheiten und Rötungen. Besonders für trockene und geschädigte Haut.",
      fr: "Une essence légère à 96 % de filtrat de bave d’escargot qui répare, hydrate et régénère. Elle renforce la barrière cutanée, repulpe la peau d’une hydratation durable et affine le grain de peau tout en apaisant imperfections et rougeurs. Idéale pour les peaux sèches et abîmées.",
      it: "Un’essenza leggera con il 96 % di filtrato di bava di lumaca che ripara, idrata e rigenera. Rafforza la barriera cutanea, rimpolpa la pelle con un’idratazione duratura e affina la grana della pelle, lenendo imperfezioni e rossori. Ideale per pelli secche e danneggiate.",
    },
    ingredients: {
      en: "96 % snail secretion filtrate. Free from parabens and silicones.",
      de: "96 % Schneckenschleimfiltrat. Frei von Parabenen und Silikonen.",
      fr: "96 % de filtrat de bave d’escargot. Sans parabènes ni silicones.",
      it: "96 % di filtrato di bava di lumaca. Senza parabeni e siliconi.",
    },
  },
  {
    key: "anua-glow-pad", title: "Anua PDRN Hyaluronic Glow Pad", size: "60 pads", type: "tonerPads", price: 2690,
    shots: [{ poster: 29, rect: [0.44, 0.3, 1, 0.84] }], posters: [29],
    description: {
      en: "Toner pads with PDRN and hyaluronic acid for radiant, hydrated and calm skin every day. They give deep hydration, refine the skin texture for a natural glow and soothe sensitive skin. One pad, one step: perfect for a quick daily routine.",
      de: "Für strahlende, hydratisierte und beruhigte Haut – jeden Tag. Mit PDRN und Hyaluronsäure für tiefenwirksame Hydration, verfeinert das Hautbild für einen natürlichen Glow und beruhigt empfindliche Haut. Einfach in der Anwendung, perfekt für die tägliche Skincare-Routine.",
      fr: "Des disques tonifiants au PDRN et à l’acide hyaluronique pour une peau lumineuse, hydratée et apaisée au quotidien. Ils hydratent en profondeur, affinent le grain de peau pour un éclat naturel et apaisent les peaux sensibles. Un disque, une étape : idéal pour une routine rapide.",
      it: "Dischetti tonificanti con PDRN e acido ialuronico per una pelle luminosa, idratata e calma ogni giorno. Idratano in profondità, affinano la grana per un glow naturale e leniscono le pelli sensibili. Un dischetto, un passaggio: perfetti per una routine veloce.",
    },
    ingredients: {
      en: "PDRN and hyaluronic acid.",
      de: "PDRN und Hyaluronsäure.",
      fr: "PDRN et acide hyaluronique.",
      it: "PDRN e acido ialuronico.",
    },
  },

  // ───────────── Serums & ampoules ─────────────
  {
    key: "innisfree-green-tea-serum", title: "Innisfree Green Tea Seed Hyaluronic Serum", size: "80 ml", type: "serum", price: 3490,
    shots: [{ poster: 11, rect: [0, 0.22, 0.52, 0.93] }], posters: [11],
    description: {
      en: "A hydrating serum with hyaluronic acid and green tea from Jeju for moisture, balance and radiant skin. It prevents dryness, calms and protects with amino acids and antioxidants, and leaves skin revitalised and glowing. Light, fast-absorbing and never sticky.",
      de: "Feuchtigkeit. Balance. Strahlende Haut. Hyaluronsäure spendet Feuchtigkeit und bewahrt die Haut vor dem Austrocknen, grüner Tee aus Jeju liefert Aminosäuren und Antioxidantien, beruhigt und schützt. Für einen frischen, strahlenden Teint – leicht, schnell einziehend und ohne zu kleben.",
      fr: "Un sérum hydratant à l’acide hyaluronique et au thé vert de Jeju pour une peau hydratée, équilibrée et lumineuse. Il prévient le dessèchement, apaise et protège grâce aux acides aminés et antioxydants. Léger, il pénètre vite sans coller.",
      it: "Un siero idratante con acido ialuronico e tè verde di Jeju per una pelle idratata, equilibrata e luminosa. Previene la secchezza, lenisce e protegge con aminoacidi e antiossidanti. Leggero, si assorbe in fretta senza appiccicare.",
    },
    ingredients: {
      en: "Hyaluronic acid and green tea from Jeju (amino acids, antioxidants). Vegan.",
      de: "Hyaluronsäure und grüner Tee aus Jeju (Aminosäuren, Antioxidantien). Vegan.",
      fr: "Acide hyaluronique et thé vert de Jeju (acides aminés, antioxydants). Vegan.",
      it: "Acido ialuronico e tè verde di Jeju (aminoacidi, antiossidanti). Vegano.",
    },
  },
  {
    key: "boj-revive-eye", title: "Beauty of Joseon Revive Eye Serum Ginseng + Retinal", type: "eyeSerum", price: 2290,
    shots: [{ poster: 12, rect: [0, 0.14, 0.46, 0.935] }], posters: [12],
    description: {
      en: "A highly effective eye serum with ginseng and retinal for a visibly smoother, firmer and brighter eye area. Ginseng revitalises and strengthens delicate skin, retinal supports cell renewal and reduces fine lines, and intense moisture keeps the area supple. Gentle enough for sensitive skin.",
      de: "Ein hochwirksames Augenserum mit Ginseng und Retinal für sichtbar glattere, straffere und strahlendere Augenpartie. Ginseng-Extrakt vitalisiert und stärkt, Retinal unterstützt die Zellerneuerung und mindert feine Linien, intensive Feuchtigkeit bewahrt die Elastizität. Speziell für die empfindliche Augenpartie entwickelt.",
      fr: "Un sérum contour des yeux très efficace au ginseng et au rétinal pour un regard visiblement plus lisse, plus ferme et plus lumineux. Le ginseng revitalise, le rétinal soutient le renouvellement cellulaire et atténue les ridules, et une hydratation intense préserve la souplesse. Spécialement conçu pour la zone délicate des yeux.",
      it: "Un siero contorno occhi molto efficace con ginseng e retinale per uno sguardo visibilmente più liscio, tonico e luminoso. Il ginseng rivitalizza, il retinale sostiene il rinnovamento cellulare e attenua le linee sottili, e un’idratazione intensa preserva l’elasticità. Studiato per la zona delicata degli occhi.",
    },
    ingredients: {
      en: "Ginseng extract and retinal. Vegan, cruelty-free.",
      de: "Ginseng-Extrakt und Retinal. Vegan, tierversuchsfrei.",
      fr: "Extrait de ginseng et rétinal. Vegan, non testé sur les animaux.",
      it: "Estratto di ginseng e retinale. Vegano, cruelty-free.",
    },
  },
  {
    key: "boj-glow-serum", title: "Beauty of Joseon Glow Serum Propolis + Niacinamide", type: "serum", price: 1990, badge: "bestseller",
    shots: [{ poster: 13, rect: [0, 0.14, 0.5, 0.93] }], posters: [13],
    description: {
      en: "A glow serum with 60 % propolis extract and niacinamide for radiant, deeply cared-for skin. Propolis nourishes and strengthens the skin barrier, niacinamide refines the complexion and evens the skin tone, and the light texture absorbs quickly. Suitable for all skin types, including sensitive skin.",
      de: "Strahlende Haut, tiefenwirksam gepflegt. Propolis-Extrakt (60 %) nährt und stärkt die Hautbarriere, Niacinamid verfeinert das Hautbild und sorgt für einen ebenmässigen Teint. Leichte, nicht klebrige Textur, zieht schnell ein und spendet intensive Feuchtigkeit. Für alle Hauttypen, auch für empfindliche Haut.",
      fr: "Un sérum éclat à 60 % d’extrait de propolis et niacinamide pour une peau lumineuse et nourrie en profondeur. La propolis nourrit et renforce la barrière cutanée, la niacinamide affine le grain de peau et unifie le teint, et la texture légère pénètre vite. Pour tous les types de peau, même sensibles.",
      it: "Un siero illuminante con il 60 % di estratto di propoli e niacinamide per una pelle luminosa e nutrita in profondità. La propoli nutre e rafforza la barriera cutanea, la niacinamide affina la grana e uniforma l’incarnato, e la texture leggera si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.",
    },
    ingredients: {
      en: "60 % propolis extract and niacinamide. Vegan, cruelty-free.",
      de: "60 % Propolis-Extrakt und Niacinamid. Vegan, tierversuchsfrei.",
      fr: "60 % d’extrait de propolis et niacinamide. Vegan, non testé sur les animaux.",
      it: "60 % di estratto di propoli e niacinamide. Vegano, cruelty-free.",
    },
  },
  {
    key: "torriden-dive-in", title: "Torriden Dive-In Serum", type: "serum", price: 2490,
    shots: [{ poster: 16, rect: [0.53, 0.05, 1, 0.97], blur: [[0.77, 0.02, 1, 0.22]] }], posters: [16],
    description: {
      en: "A hydrating serum with low-molecular hyaluronic acid for plump, healthy-looking skin. It penetrates deeply for long-lasting moisture, strengthens the skin barrier and leaves a refreshing, non-sticky finish. Mild enough for sensitive skin and for all skin types.",
      de: "Intensive Feuchtigkeit für pralle, gesunde Haut. Das DIVE IN Serum mit niedermolekularer Hyaluronsäure spendet tiefenwirksam Feuchtigkeit, beruhigt die Haut und stärkt die natürliche Hautbarriere. Leichte, nicht klebrige Textur – perfekt für jeden Hauttyp, auch für empfindliche Haut.",
      fr: "Un sérum hydratant à l’acide hyaluronique de faible poids moléculaire pour une peau repulpée et saine. Il pénètre en profondeur pour une hydratation durable, renforce la barrière cutanée et laisse un fini frais et non collant. Assez doux pour les peaux sensibles et tous les types de peau.",
      it: "Un siero idratante con acido ialuronico a basso peso molecolare per una pelle rimpolpata e sana. Penetra in profondità per un’idratazione duratura, rafforza la barriera cutanea e lascia un finish fresco e non appiccicoso. Delicato per pelli sensibili e tutti i tipi di pelle.",
    },
    ingredients: {
      en: "Low-molecular hyaluronic acid. Free from parabens, mineral oils and alcohol. Cruelty-free.",
      de: "Niedermolekulare Hyaluronsäure. Frei von Parabenen, Mineralölen und Alkohol. Tierversuchsfrei.",
      fr: "Acide hyaluronique de faible poids moléculaire. Sans parabènes, huiles minérales ni alcool. Non testé sur les animaux.",
      it: "Acido ialuronico a basso peso molecolare. Senza parabeni, oli minerali e alcol. Cruelty-free.",
    },
  },
  {
    key: "anua-100-hyaluron", title: "Anua 100+ Hyaluron Serum", size: "30 ml", type: "serum", price: 2790,
    shots: [{ poster: 27, rect: [0.52, 0, 1, 0.84] }], posters: [27],
    description: {
      en: "An intensive hydrating serum with 10 types of hyaluronic acid for plump, glowing skin. It gives long-lasting moisture, smooths fine lines, strengthens the skin barrier and absorbs quickly, perfect for daily care and under make-up. Suitable for all skin types.",
      de: "Intensive Feuchtigkeit für pralle, gesunde Haut. Mit 10 Arten von Hyaluronsäure für maximale Feuchtigkeitsversorgung: polstert auf und glättet feine Linien, stärkt die Hautbarriere und zieht schnell ein – perfekt für die tägliche Pflege, auch unter Make-up. Für alle Hauttypen.",
      fr: "Un sérum hydratant intensif à 10 types d’acide hyaluronique pour une peau repulpée et éclatante. Il hydrate durablement, lisse les ridules, renforce la barrière cutanée et pénètre vite, idéal au quotidien et sous le maquillage. Pour tous les types de peau.",
      it: "Un siero idratante intensivo con 10 tipi di acido ialuronico per una pelle rimpolpata e luminosa. Idrata a lungo, leviga le linee sottili, rafforza la barriera cutanea e si assorbe in fretta, perfetto ogni giorno e sotto il trucco. Per tutti i tipi di pelle.",
    },
    ingredients: {
      en: "10 types of hyaluronic acid, including FORN hyaluronic acid capsules.",
      de: "10 Arten von Hyaluronsäure, darunter FORN-Hyaluronsäure-Kapseln.",
      fr: "10 types d’acide hyaluronique, dont des capsules d’acide hyaluronique FORN.",
      it: "10 tipi di acido ialuronico, tra cui capsule di acido ialuronico FORN.",
    },
  },
  {
    key: "medicube-pdrn-pink", title: "Medicube PDRN Pink Peptide Serum", size: "30 ml", type: "serum", price: 3490,
    shots: [{ poster: 28, rect: [0.31, 0, 1, 0.8], blur: [[0.81, 0.67, 0.98, 0.8], [0.3, 0.1, 0.42, 0.3]] }], posters: [28],
    description: {
      en: "A regenerating serum with PDRN and peptides for radiant, smooth and healthy-looking skin. PDRN supports skin renewal and recovery, peptides improve elasticity and firmness, and deep hydration leaves a fresh, natural glow. Dermatologically tested and suitable for all skin types.",
      de: "Für strahlende, glatte und gesunde Haut. PDRN fördert die Hauterneuerung und unterstützt die Heilung, Peptide verbessern die Hautstruktur und sorgen für mehr Spannkraft, tiefenwirksame Feuchtigkeit verleiht einen natürlichen Glow. Dermatologisch getestet und für alle Hauttypen geeignet.",
      fr: "Un sérum régénérant au PDRN et aux peptides pour une peau lumineuse, lisse et saine. Le PDRN soutient le renouvellement et la réparation de la peau, les peptides améliorent élasticité et fermeté, et une hydratation profonde apporte un éclat naturel. Testé dermatologiquement, pour tous les types de peau.",
      it: "Un siero rigenerante con PDRN e peptidi per una pelle luminosa, liscia e sana. Il PDRN sostiene il rinnovamento e la riparazione della pelle, i peptidi migliorano elasticità e tonicità e un’idratazione profonda dona un glow naturale. Dermatologicamente testato, per tutti i tipi di pelle.",
    },
    ingredients: {
      en: "PDRN (sodium DNA) and a 5-type peptide complex. Vegan, free from parabens and artificial colours. Made in Korea.",
      de: "PDRN (Natrium-DNA) und ein Komplex aus 5 Peptiden. Vegan, frei von Parabenen und künstlichen Farbstoffen. Hergestellt in Korea.",
      fr: "PDRN (ADN de sodium) et complexe de 5 peptides. Vegan, sans parabènes ni colorants artificiels. Fabriqué en Corée.",
      it: "PDRN (DNA di sodio) e complesso di 5 peptidi. Vegano, senza parabeni e coloranti artificiali. Prodotto in Corea.",
    },
  },

  // ───────────── Sun care ─────────────
  {
    key: "boj-relief-sun", title: "Beauty of Joseon Relief Sun Rice + Probiotics SPF50+ PA++++", type: "sunscreen", price: 1990, badge: "bestseller",
    shots: [{ poster: 22, rect: [0.46, 0.1, 1, 0.98], blur: [[0.84, 0, 1, 0.19]] }], posters: [22],
    description: {
      en: "A light, moisturising sunscreen with rice bran extract and probiotics for healthy, radiant skin. SPF50+ PA++++ gives reliable protection against UVA and UVB, while the non-greasy texture absorbs quickly and suits all skin types, including sensitive skin.",
      de: "Sonnenschutz. Pflege. Strahlender Teint. Leichte, feuchtigkeitsspendende Sonnencreme mit Reiskleie-Extrakt und probiotischen Inhaltsstoffen. SPF50+ PA++++ schützt zuverlässig vor UVA- und UVB-Strahlung, zieht schnell ein und hinterlässt kein fettiges Gefühl. Für alle Hauttypen, auch für empfindliche Haut.",
      fr: "Une crème solaire légère et hydratante à l’extrait de son de riz et aux probiotiques pour une peau saine et lumineuse. SPF50+ PA++++ protège efficacement des UVA et UVB, avec une texture non grasse qui pénètre vite. Pour tous les types de peau, même sensibles.",
      it: "Una crema solare leggera e idratante con estratto di crusca di riso e probiotici per una pelle sana e luminosa. SPF50+ PA++++ protegge efficacemente da UVA e UVB, con una texture non grassa che si assorbe in fretta. Per tutti i tipi di pelle, anche sensibili.",
    },
    ingredients: {
      en: "Rice bran extract and probiotics. Free from parabens and artificial fragrance. Cruelty-free.",
      de: "Reiskleie-Extrakt und Probiotika. Frei von Parabenen und künstlichen Duftstoffen. Tierversuchsfrei.",
      fr: "Extrait de son de riz et probiotiques. Sans parabènes ni parfums artificiels. Non testé sur les animaux.",
      it: "Estratto di crusca di riso e probiotici. Senza parabeni e profumi artificiali. Cruelty-free.",
    },
  },

  // ───────────── Masks & treatments ─────────────
  {
    key: "laneige-water-sleeping", title: "Laneige Water Sleeping Mask", size: "70 ml", type: "sleepingMask", price: 3290,
    shots: [{ poster: 9, rect: [0, 0.305, 0.55, 0.74] }], posters: [9],
    description: {
      en: "An overnight mask for radiant, hydrated skin by morning. It moisturises intensively while you sleep, leaves a fresh glow and smoother, softer skin, with a light gel texture that absorbs quickly. Dermatologically tested and suitable for all skin types.",
      de: "Über Nacht zu strahlender, hydratisierter Haut. Versorgt die Haut über Nacht intensiv mit Feuchtigkeit, für einen frischen, strahlenden Teint am Morgen, verbessert die Hautstruktur und macht sie zart und geschmeidig. Leichte Gel-Textur, zieht schnell ein. Dermatologisch getestet, für alle Hauttypen.",
      fr: "Un masque de nuit pour une peau lumineuse et hydratée au réveil. Il hydrate intensément pendant le sommeil, apporte un éclat frais et une peau plus lisse et plus douce, avec une texture gel légère qui pénètre vite. Testé dermatologiquement, pour tous les types de peau.",
      it: "Una maschera notte per una pelle luminosa e idratata al risveglio. Idrata intensamente durante il sonno, dona un glow fresco e una pelle più liscia e morbida, con una texture in gel leggera che si assorbe in fretta. Dermatologicamente testata, per tutti i tipi di pelle.",
    },
  },
  {
    key: "merikit-calming-mask", title: "Merikit Regenerating Calming Mask", type: "creamMask", price: 2890,
    shots: [{ poster: 32, rect: [0.4, 0.255, 1, 0.76] }], posters: [32],
    description: {
      en: "A regenerating calming mask for healthy, radiant skin. It soothes irritation and redness, gives intense moisture, supports the skin’s natural regeneration and strengthens it. High-quality ingredients from nature and science, suitable for all skin types, including sensitive skin.",
      de: "Regeneration. Beruhigung. Balance. Die Maske hilft, Rötungen zu reduzieren und die Haut spürbar zu beruhigen, spendet intensiv Feuchtigkeit, unterstützt die natürliche Regeneration und stärkt die Haut. Hochwertige Inhaltsstoffe aus Natur und Wissenschaft – für alle Hauttypen, auch für empfindliche Haut.",
      fr: "Un masque apaisant et régénérant pour une peau saine et lumineuse. Il calme irritations et rougeurs, hydrate intensément, soutient la régénération naturelle et renforce la peau. Des ingrédients de qualité, entre nature et science, pour tous les types de peau, même sensibles.",
      it: "Una maschera lenitiva e rigenerante per una pelle sana e luminosa. Calma irritazioni e rossori, idrata intensamente, sostiene la rigenerazione naturale e rinforza la pelle. Ingredienti di qualità tra natura e scienza, per tutti i tipi di pelle, anche sensibili.",
    },
  },
  {
    key: "torriden-balanceful-mask", title: "Torriden Balanceful Cica Mask", type: "sheetMask", price: 390,
    shots: [{ poster: 34, rect: [0.05, 0.2, 0.27, 0.71], blur: [[0, 0.17, 1, 0.215]] }], posters: [34],
    description: {
      en: "A soothing sheet mask with cica that calms and balances the skin. Ideal after a long day or when skin feels stressed and irritated. Suitable for all skin types.",
      de: "Eine beruhigende Tuchmaske mit Cica, die die Haut besänftigt und ins Gleichgewicht bringt. Ideal nach einem langen Tag oder wenn die Haut gestresst und gereizt ist. Für alle Hauttypen.",
      fr: "Un masque en tissu apaisant à la cica qui calme et rééquilibre la peau. Idéal après une longue journée ou quand la peau est stressée et irritée. Pour tous les types de peau.",
      it: "Una maschera in tessuto lenitiva alla cica che calma e riequilibra la pelle. Ideale dopo una lunga giornata o quando la pelle è stressata e irritata. Per tutti i tipi di pelle.",
    },
  },
  {
    key: "mediheal-collagen-mask", title: "Mediheal Collagen Mask", type: "sheetMask", price: 350,
    shots: [{ poster: 34, rect: [0.285, 0.2, 0.5, 0.71], blur: [[0, 0.17, 1, 0.215]] }], posters: [34],
    description: {
      en: "A sheet mask with collagen that hydrates and improves skin elasticity. For skin that feels dry or tired and could use some extra bounce. Suitable for all skin types.",
      de: "Eine Tuchmaske mit Kollagen, die Feuchtigkeit spendet und die Elastizität der Haut verbessert. Für trockene oder müde Haut, die etwas mehr Spannkraft gebrauchen kann. Für alle Hauttypen.",
      fr: "Un masque en tissu au collagène qui hydrate et améliore l’élasticité de la peau. Pour les peaux sèches ou fatiguées qui ont besoin de rebond. Pour tous les types de peau.",
      it: "Una maschera in tessuto al collagene che idrata e migliora l’elasticità della pelle. Per pelli secche o stanche che hanno bisogno di più tono. Per tutti i tipi di pelle.",
    },
  },
  {
    key: "abib-heartleaf-mask", title: "Abib Gummy Sheet Mask Heartleaf Sticker", type: "sheetMask", price: 490,
    shots: [{ poster: 34, rect: [0.505, 0.2, 0.712, 0.71], blur: [[0, 0.17, 1, 0.215]] }], posters: [34],
    description: {
      en: "A soothing gummy sheet mask with heartleaf that calms sensitive skin. The soft, adhering sheet sits close to the skin for a comfortable treatment. Ideal for sensitive and irritated skin.",
      de: "Eine beruhigende Gummy-Tuchmaske mit Herzblatt, die empfindliche Haut besänftigt. Das weiche, haftende Tuch liegt eng an der Haut an. Ideal für empfindliche und gereizte Haut.",
      fr: "Un masque gummy apaisant au houttuynia qui calme les peaux sensibles. Le tissu doux et adhérent épouse parfaitement la peau. Idéal pour les peaux sensibles et irritées.",
      it: "Una maschera gummy lenitiva all’houttuynia che calma le pelli sensibili. Il tessuto morbido e aderente si adatta perfettamente alla pelle. Ideale per pelli sensibili e irritate.",
    },
  },
  {
    key: "mediheal-vitamin-c-mask", title: "Mediheal Vitamin C Mask", type: "sheetMask", price: 350,
    shots: [{ poster: 34, rect: [0.728, 0.2, 0.965, 0.71], blur: [[0, 0.17, 1, 0.215]] }], posters: [34],
    description: {
      en: "A brightening sheet mask with vitamin C that revitalises the skin for a more luminous complexion. Perfect when skin looks dull or tired. Suitable for all skin types.",
      de: "Eine Tuchmaske mit Vitamin C, die die Haut belebt und für einen strahlenderen Teint sorgt. Perfekt, wenn die Haut fahl oder müde aussieht. Für alle Hauttypen.",
      fr: "Un masque en tissu à la vitamine C qui revitalise la peau pour un teint plus lumineux. Parfait quand le teint est terne ou fatigué. Pour tous les types de peau.",
      it: "Una maschera in tessuto alla vitamina C che rivitalizza la pelle per un incarnato più luminoso. Perfetta quando la pelle appare spenta o stanca. Per tutti i tipi di pelle.",
    },
  },

  // ───────────── Lip care ─────────────
  {
    key: "torriden-lip-essence", title: "Torriden Solid-In Lip Essence", type: "lipEssence", price: 1490,
    shots: [{ poster: 25, rect: [0.36, 0.32, 1, 0.72], blur: [[0.72, 0.1, 0.94, 0.27]] }], posters: [25],
    description: {
      en: "A rich lip essence for soft, cared-for and healthy lips. It gives long-lasting moisture and protects against drying out, smooths and softens the lips and strengthens their natural barrier. Mild, vegan formula in a handy tube for on the go.",
      de: "Intensive Pflege für zarte Lippen. Reichhaltige Essenz für geschmeidige, gepflegte und gesunde Lippen: spendet langanhaltend Feuchtigkeit, schützt vor dem Austrocknen und stärkt die natürliche Lippenbarriere. Milde, vegane Formel, praktisch und kompakt für unterwegs.",
      fr: "Une essence riche pour des lèvres douces, soignées et en bonne santé. Elle hydrate durablement et protège du dessèchement, lisse et adoucit les lèvres et renforce leur barrière naturelle. Formule douce et vegan, dans un tube pratique à emporter.",
      it: "Un’essenza ricca per labbra morbide, curate e sane. Idrata a lungo e protegge dalla secchezza, leviga e ammorbidisce le labbra e ne rafforza la barriera naturale. Formula delicata e vegana, in un pratico tubetto da portare con sé.",
    },
  },
  {
    key: "laneige-lip-sleeping", title: "Laneige Lip Sleeping Mask Peach Iced Tea", size: "20 g", type: "lipMask", price: 2290, badge: "new",
    shots: [{ poster: 33, rect: [0.17, 0.27, 0.6, 0.7] }], posters: [33],
    description: {
      en: "The much-loved overnight lip mask from Laneige with a fruity peach iced tea scent. It gives intense, long-lasting moisture, supports the lips’ natural regeneration while you sleep, and leaves them visibly softer and smoother by morning.",
      de: "Die beliebte Lippenmaske von LANEIGE mit fruchtigem Pfirsich-Eistee-Duft. Spendet langanhaltende Feuchtigkeit, beugt trockenen Lippen vor und unterstützt über Nacht die natürliche Regeneration – für sichtbar weichere, glattere und gesünder aussehende Lippen am Morgen.",
      fr: "Le masque de nuit pour les lèvres culte de Laneige, au parfum fruité de thé glacé à la pêche. Il hydrate intensément et durablement, soutient la régénération naturelle des lèvres pendant le sommeil et les laisse visiblement plus douces et plus lisses au réveil.",
      it: "L’amatissima maschera notte per le labbra di Laneige, con un profumo fruttato di tè freddo alla pesca. Idrata intensamente e a lungo, sostiene la rigenerazione naturale delle labbra durante il sonno e le lascia visibilmente più morbide e lisce al risveglio.",
    },
  },

  // ───────────── Routine sets ─────────────
  {
    key: "set-dokdo", title: "Round Lab Dokdo Hydration Routine", type: "set", price: 6490,
    shots: [{ poster: 35, rect: [0.27, 0.15, 1, 0.83] }], posters: [35],
    description: {
      en: "A three-step hydration routine for skin that’s moisturised, calm and protected every day. Includes Round Lab Dokdo 1025 Toner (deep hydration), Birch Juice Moisturizing Sun Cream (moisture and UV protection) and Dokdo 1025 Mist Toner (refreshes any time). Gentle formulas for all skin types.",
      de: "Eine dreistufige Feuchtigkeitsroutine für hydratisierte, beruhigte und geschützte Haut – jeden Tag. Enthält Round Lab Dokdo 1025 Toner (tiefenwirksame Feuchtigkeit), Birch Juice Moisturizing Sun Cream (Feuchtigkeit und UV-Schutz) und Dokdo 1025 Mist Toner (erfrischt jederzeit). Sanfte Formeln für alle Hauttypen.",
      fr: "Une routine hydratation en trois étapes pour une peau hydratée, apaisée et protégée au quotidien. Comprend Round Lab Dokdo 1025 Toner (hydratation profonde), Birch Juice Moisturizing Sun Cream (hydratation et protection UV) et Dokdo 1025 Mist Toner (rafraîchit à tout moment). Formules douces pour tous les types de peau.",
      it: "Una routine idratante in tre passaggi per una pelle idratata, calma e protetta ogni giorno. Include Round Lab Dokdo 1025 Toner (idratazione profonda), Birch Juice Moisturizing Sun Cream (idratazione e protezione UV) e Dokdo 1025 Mist Toner (rinfresca in ogni momento). Formule delicate per tutti i tipi di pelle.",
    },
    howToUse: {
      en: "1. Toner after cleansing. 2. Sun cream as the last step in the morning. 3. Mist whenever skin needs a refresh, also over make-up.",
      de: "1. Toner nach der Reinigung. 2. Sonnencreme als letzter Schritt am Morgen. 3. Mist jederzeit zur Erfrischung, auch über dem Make-up.",
      fr: "1. Lotion après le nettoyage. 2. Crème solaire en dernière étape le matin. 3. Brume à tout moment pour rafraîchir, même sur le maquillage.",
      it: "1. Tonico dopo la detersione. 2. Crema solare come ultimo passaggio al mattino. 3. Mist in qualsiasi momento per rinfrescare, anche sopra il trucco.",
    },
  },
  {
    key: "set-korean-routine", title: "Korean Routine Set: Clear, Hydrated & Protected", type: "set", price: 8990,
    shots: [{ poster: 39, rect: [0.22, 0.235, 0.99, 0.765], fillFromTop: true, blur: [[0.83, 0.03, 0.99, 0.17]] }], posters: [39],
    description: {
      en: "A complete Korean routine to cleanse, soothe, hydrate and protect. Includes Lagom Cellup Micro Foam Cleanser, Anua toner pads, Manyo Pure Soybean Cleansing Oil and Mediheal Madecassoside Moisture Sun Serum. Gentle formulas for all skin types, including sensitive skin.",
      de: "Eine komplette koreanische Routine: reinigen, beruhigen, hydratisieren und schützen. Enthält Lagom Cellup Micro Foam Cleanser, Anua Toner-Pads, Manyo Pure Soybean Cleansing Oil und Mediheal Madecassoside Moisture Sun Serum. Sanfte Formeln für alle Hauttypen, auch für empfindliche Haut.",
      fr: "Une routine coréenne complète pour nettoyer, apaiser, hydrater et protéger. Comprend Lagom Cellup Micro Foam Cleanser, les disques tonifiants Anua, Manyo Pure Soybean Cleansing Oil et Mediheal Madecassoside Moisture Sun Serum. Formules douces pour tous les types de peau, même sensibles.",
      it: "Una routine coreana completa per detergere, lenire, idratare e proteggere. Include Lagom Cellup Micro Foam Cleanser, i dischetti tonificanti Anua, Manyo Pure Soybean Cleansing Oil e Mediheal Madecassoside Moisture Sun Serum. Formule delicate per tutti i tipi di pelle, anche sensibili.",
    },
    howToUse: {
      en: "Evening: cleansing oil, then foam cleanser, then a toner pad. Morning: foam cleanser, toner pad and the sun serum as the last step.",
      de: "Abends: Reinigungsöl, danach Schaumreiniger, dann ein Toner-Pad. Morgens: Schaumreiniger, Toner-Pad und als letzten Schritt das Sonnenserum.",
      fr: "Le soir : huile démaquillante, puis mousse nettoyante, puis un disque tonifiant. Le matin : mousse nettoyante, disque tonifiant et le sérum solaire en dernière étape.",
      it: "La sera: olio detergente, poi schiuma detergente, poi un dischetto tonificante. Al mattino: schiuma detergente, dischetto e il siero solare come ultimo passaggio.",
    },
  },
  {
    key: "set-glow-gentle", title: "Korean Skincare Set: Glow & Gentle", type: "set", price: 8490,
    shots: [{ poster: 40, rect: [0, 0.15, 1, 0.74] }], posters: [40],
    description: {
      en: "A glow and gentle-care routine with four steps. Includes an SPF 50+ PA++++ sun cream, Bringgreen Tea Tree Cica Soothing Toner, a brightening peeling gel and Aromatica Rosemary 3-in-1 Treatment for hair. Gentle, clean formulas suitable for sensitive skin.",
      de: "Eine Routine für Glow und sanfte Pflege in vier Schritten. Enthält eine Sonnencreme SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, ein aufhellendes Peeling-Gel und Aromatica Rosemary 3-in-1 Treatment für die Haare. Sanfte, cleane Formeln, auch für empfindliche Haut.",
      fr: "Une routine éclat et douceur en quatre étapes. Comprend une crème solaire SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling éclat et Aromatica Rosemary 3-in-1 Treatment pour les cheveux. Formules douces et clean, adaptées aux peaux sensibles.",
      it: "Una routine glow e delicatezza in quattro passaggi. Include una crema solare SPF 50+ PA++++, Bringgreen Tea Tree Cica Soothing Toner, un gel peeling illuminante e Aromatica Rosemary 3-in-1 Treatment per i capelli. Formule delicate e clean, adatte alle pelli sensibili.",
    },
    howToUse: {
      en: "Toner after cleansing, sun cream every morning, peeling gel 1–2 times a week on clean, dry skin, rosemary treatment after shampooing.",
      de: "Toner nach der Reinigung, Sonnencreme jeden Morgen, Peeling-Gel 1–2 Mal pro Woche auf sauberer, trockener Haut, Rosmarin-Treatment nach dem Shampoo.",
      fr: "Lotion après le nettoyage, crème solaire chaque matin, gel peeling 1 à 2 fois par semaine sur peau propre et sèche, soin au romarin après le shampooing.",
      it: "Tonico dopo la detersione, crema solare ogni mattina, gel peeling 1–2 volte a settimana su pelle pulita e asciutta, trattamento al rosmarino dopo lo shampoo.",
    },
  },
];

/** Homepage picks (by product key). */
export const HOME_BESTSELLERS = ["cosrx-snail-96-essence", "boj-relief-sun", "anua-heartleaf-77", "dr-althea-345", "boj-glow-serum", "mise-original"];
export const HOME_ROUTINE = ["cosrx-low-ph-cleanser", "anua-heartleaf-77", "boj-glow-serum", "dr-althea-345", "boj-relief-sun"];
export const HOME_SETS = ["set-dokdo", "set-korean-routine"];
