/**
 * Placeholder translations for the seed catalogue. Product names stay in English (as most K-beauty
 * shops keep them); the client can translate them in the admin if they want.
 */
export type SeedLocale = "de" | "fr" | "it";

type ProductText = { tagline: string; blurb: string };

export const PRODUCT_TEXT: Record<SeedLocale, Record<string, ProductText>> = {
  de: {
    "p-hydra": { tagline: "Feuchtigkeitsessenz", blurb: "Eine leichte, schichtbare Essenz, die die Haut prall und taufrisch wirken lässt." },
    "p-barrier": { tagline: "Barriere-Creme", blurb: "Eine kissenweiche Creme, die trockene, gestresste Haut über Nacht beruhigt." },
    "p-soothe": { tagline: "Beruhigendes Serum", blurb: "Mildert sichtbare Rötungen und lässt die Haut zur Ruhe kommen." },
    "p-bright": { tagline: "Aufhellendes Gesichtswasser", blurb: "Ein seidiges Gesichtswasser für einen ebenmässigen, strahlenden Teint." },
    "p-pore": { tagline: "Abwaschbare Maske", blurb: "Nimmt überschüssiges Öl auf und verfeinert sichtbar das Hautbild." },
    "p-blem": { tagline: "Gel gegen Unreinheiten", blurb: "Ein gezieltes Gel für Stellen, die zu Unreinheiten neigen." },
    "p-exfo": { tagline: "Peeling-Reinigung", blurb: "Tägliche Glättung ohne Brennen." },
    "p-firm": { tagline: "Straffende Ampulle", blurb: "Eine reichhaltige Ampulle für Spannkraft und ein glatteres Hautbild." },
    "p-line": { tagline: "Anti-Aging-Creme", blurb: "Für feine Linien um Mund und Stirn." },
    "p-sun": { tagline: "Sonnenschutz", blurb: "Ein schwereloses Fluid ohne weissen Schleier für jeden Tag." },
    "p-eye": { tagline: "Augenbalsam", blurb: "Ein kühlender Balsam, der die Augenpartie erfrischt." },
    "p-lip": { tagline: "Lippenpflege", blurb: "Eine glänzende Nachtmaske für weiche, glatte Lippen." },
  },
  fr: {
    "p-hydra": { tagline: "Essence hydratante", blurb: "Une essence légère à superposer, pour une peau rebondie et éclatante." },
    "p-barrier": { tagline: "Crème barrière", blurb: "Une crème enveloppante qui réconforte les peaux sèches et stressées pendant la nuit." },
    "p-soothe": { tagline: "Sérum apaisant", blurb: "Atténue les rougeurs visibles et aide la peau à retrouver son calme." },
    "p-bright": { tagline: "Lotion éclat", blurb: "Une lotion soyeuse pour un teint unifié et lumineux." },
    "p-pore": { tagline: "Masque à rincer", blurb: "Absorbe l’excès de sébum et resserre visiblement les pores." },
    "p-blem": { tagline: "Gel anti-imperfections", blurb: "Un gel ciblé pour les zones sujettes aux imperfections." },
    "p-exfo": { tagline: "Nettoyant exfoliant", blurb: "Une peau lissée au quotidien, sans picotements." },
    "p-firm": { tagline: "Ampoule raffermissante", blurb: "Une ampoule riche pour du rebond et un grain de peau plus lisse." },
    "p-line": { tagline: "Crème anti-âge", blurb: "Cible l’apparence des ridules autour de la bouche et du front." },
    "p-sun": { tagline: "Protection solaire", blurb: "Un fluide ultra-léger sans traces blanches, pour tous les jours." },
    "p-eye": { tagline: "Baume contour des yeux", blurb: "Un baume rafraîchissant pour réveiller le regard." },
    "p-lip": { tagline: "Soin des lèvres", blurb: "Un masque de nuit brillant pour des lèvres douces et lisses." },
  },
  it: {
    "p-hydra": { tagline: "Essenza idratante", blurb: "Un’essenza leggera da stratificare, per una pelle rimpolpata e luminosa." },
    "p-barrier": { tagline: "Crema barriera", blurb: "Una crema avvolgente che conforta la pelle secca e stressata durante la notte." },
    "p-soothe": { tagline: "Siero lenitivo", blurb: "Attenua i rossori visibili e aiuta la pelle a ritrovare equilibrio." },
    "p-bright": { tagline: "Tonico illuminante", blurb: "Un tonico setoso per un incarnato uniforme e luminoso." },
    "p-pore": { tagline: "Maschera da risciacquare", blurb: "Assorbe il sebo in eccesso e minimizza visibilmente i pori." },
    "p-blem": { tagline: "Gel anti-imperfezioni", blurb: "Un gel mirato per le zone soggette a imperfezioni." },
    "p-exfo": { tagline: "Detergente esfoliante", blurb: "Pelle levigata ogni giorno, senza bruciore." },
    "p-firm": { tagline: "Fiala rassodante", blurb: "Una fiala ricca per elasticità e una pelle dall’aspetto più liscio." },
    "p-line": { tagline: "Crema antietà", blurb: "Agisce sull’aspetto delle rughe sottili intorno a bocca e fronte." },
    "p-sun": { tagline: "Protezione solare", blurb: "Un fluido leggerissimo senza aloni bianchi, per tutti i giorni." },
    "p-eye": { tagline: "Balsamo contorno occhi", blurb: "Un balsamo rinfrescante che risveglia lo sguardo." },
    "p-lip": { tagline: "Trattamento labbra", blurb: "Una maschera notte lucida per labbra morbide e lisce." },
  },
};

export const COMMON_TEXT: Record<SeedLocale, { placeholder: string; howToUse: string; ingredients: string; setNote: string; boxed: string }> = {
  de: {
    placeholder: "Platzhaltertext: im Admin durch die echte Produktbeschreibung ersetzen.",
    howToUse: "Nach der Reinigung eine kleine Menge auf Gesicht und Hals auftragen. Morgens und abends anwenden.",
    ingredients: "Platzhalter: Hier die wichtigsten Inhaltsstoffe und ihre Konzentrationen auflisten.",
    setNote: "3er-Set",
    boxed: "im Set. Platzhaltertext.",
  },
  fr: {
    placeholder: "Texte provisoire : à remplacer par la vraie description dans l’admin.",
    howToUse: "Après le nettoyage, appliquer une petite quantité sur le visage et le cou. Utiliser matin et soir.",
    ingredients: "Provisoire : indiquer ici les ingrédients clés et leurs concentrations.",
    setNote: "Coffret de 3",
    boxed: "réunis en coffret. Texte provisoire.",
  },
  it: {
    placeholder: "Testo provvisorio: sostituirlo con la vera descrizione del prodotto nell’admin.",
    howToUse: "Dopo la detersione, applicare una piccola quantità su viso e collo. Usare mattina e sera.",
    ingredients: "Provvisorio: elencare qui gli ingredienti principali e le loro concentrazioni.",
    setNote: "Set da 3",
    boxed: "in un’unica confezione. Testo provvisorio.",
  },
};

export const SET_TEXT: Record<SeedLocale, Record<string, string>> = {
  de: { "s-glow": "Gesichtswasser, Serum, Creme", "s-calm": "Essenz, Ampulle, Sonnenschutz" },
  fr: { "s-glow": "Lotion, sérum, crème", "s-calm": "Essence, ampoule, SPF" },
  it: { "s-glow": "Tonico, siero, crema", "s-calm": "Essenza, fiala, SPF" },
};

export const CATEGORY_TEXT: Record<SeedLocale, Record<string, string>> = {
  de: {
    cleansers: "Reinigung",
    toners: "Gesichtswasser & Essenzen",
    serums: "Seren & Ampullen",
    moisturisers: "Feuchtigkeitspflege",
    suncare: "Sonnenschutz",
    treatments: "Masken & Spezialpflege",
    sets: "Routine-Sets",
  },
  fr: {
    cleansers: "Nettoyants",
    toners: "Lotions & essences",
    serums: "Sérums & ampoules",
    moisturisers: "Hydratants",
    suncare: "Protection solaire",
    treatments: "Masques & soins ciblés",
    sets: "Coffrets routine",
  },
  it: {
    cleansers: "Detergenti",
    toners: "Tonici & essenze",
    serums: "Sieri & fiale",
    moisturisers: "Idratanti",
    suncare: "Protezione solare",
    treatments: "Maschere & trattamenti",
    sets: "Set routine",
  },
};

export const HOME_TEXT: Record<
  SeedLocale,
  { announcements: string[]; hero: { title: string; lede: string }; routine: { title: string; note: string }[] }
> = {
  de: {
    announcements: [
      "Kostenloser Versand in die Schweiz & nach Liechtenstein",
      "Bezahle mit TWINT, Karte, Apple Pay oder Google Pay",
      "Gratis-Probe zu deiner ersten Bestellung",
    ],
    hero: { title: "Hautpflege, die zu jeder Haut passt.", lede: "Koreanisch formulierte Routinen, einfach und sanft zu jeder Haut." },
    routine: [
      { title: "Reinigen", note: "Entfernt Öl und Sonnenschutz, ohne auszutrocknen." },
      { title: "Klären", note: "Bereitet die Haut vor, damit alles Weitere besser einzieht." },
      { title: "Pflegen", note: "Ein Serum für das Anliegen, das dir am wichtigsten ist." },
      { title: "Feuchtigkeit", note: "Mit einer Creme, die zu deiner Haut passt, versiegeln." },
      { title: "Schützen", note: "Jeden Morgen mit Breitband-Sonnenschutz abschliessen." },
    ],
  },
  fr: {
    announcements: [
      "Livraison gratuite en Suisse et au Liechtenstein",
      "Payez avec TWINT, carte, Apple Pay ou Google Pay",
      "Échantillon offert avec votre première commande",
    ],
    hero: { title: "Des soins pour toutes les peaux.", lede: "Des routines de formulation coréenne, simples et douces pour toutes les peaux." },
    routine: [
      { title: "Nettoyer", note: "Élimine le sébum et la protection solaire sans dessécher." },
      { title: "Tonifier", note: "Prépare la peau pour que la suite pénètre mieux." },
      { title: "Traiter", note: "Un sérum pour la préoccupation qui compte le plus pour vous." },
      { title: "Hydrater", note: "Scellez le tout avec une crème adaptée à votre peau." },
      { title: "Protéger", note: "Terminez chaque matin par une protection solaire à large spectre." },
    ],
  },
  it: {
    announcements: [
      "Spedizione gratuita in Svizzera e nel Liechtenstein",
      "Paga con TWINT, carta, Apple Pay o Google Pay",
      "Campione omaggio con il tuo primo ordine",
    ],
    hero: { title: "Skincare adatta a ogni pelle.", lede: "Routine di formulazione coreana, semplici e delicate su ogni pelle." },
    routine: [
      { title: "Detergere", note: "Rimuove sebo e protezione solare senza seccare." },
      { title: "Tonificare", note: "Prepara la pelle perché tutto il resto si assorba meglio." },
      { title: "Trattare", note: "Un siero per l’esigenza che ti sta più a cuore." },
      { title: "Idratare", note: "Sigilla il tutto con una crema adatta alla tua pelle." },
      { title: "Proteggere", note: "Concludi ogni mattina con una protezione solare ad ampio spettro." },
    ],
  },
};
