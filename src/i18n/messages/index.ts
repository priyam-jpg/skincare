import type { Locale } from "../config";

import { de } from "./de";
import { en, type Messages } from "./en";
import { fr } from "./fr";
import { it } from "./it";

export type { Messages };

export const messages: Record<Locale, Messages> = { de, fr, it, en };
