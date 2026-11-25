import type { SVGProps } from "react";

/** One icon family: 24px grid, 1.6 stroke, round caps. Decorative by default (aria-hidden). */
function Svg(props: SVGProps<SVGSVGElement>) {
  return (
    <svg
      width="22"
      height="22"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.6"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
      focusable="false"
      {...props}
    />
  );
}

export const SearchIcon = () => (
  <Svg><circle cx="11" cy="11" r="6.5" /><path d="m16 16 4.5 4.5" /></Svg>
);
export const UserIcon = () => (
  <Svg><circle cx="12" cy="8.5" r="3.8" /><path d="M4.5 20c.8-3.6 3.8-5.5 7.5-5.5s6.7 1.9 7.5 5.5" /></Svg>
);
export const BagIcon = () => (
  <Svg><path d="M5 8h14l-1 12H6z" /><path d="M9 8V6.5a3 3 0 0 1 6 0V8" /></Svg>
);
export const MenuIcon = () => (
  <Svg><path d="M4 7h16M4 12h16M4 17h16" /></Svg>
);
export const CloseIcon = () => (
  <Svg><path d="m6 6 12 12M18 6 6 18" /></Svg>
);
export const ArrowLeftIcon = () => (
  <Svg><path d="M19 12H5m6-6-6 6 6 6" /></Svg>
);
export const ArrowRightIcon = () => (
  <Svg><path d="M5 12h14m-6-6 6 6-6 6" /></Svg>
);
export const StarIcon = ({ filled }: { filled: boolean }) => (
  <Svg width="16" height="16" fill={filled ? "currentColor" : "none"}>
    <path d="m12 3.5 2.6 5.4 5.9.8-4.3 4.1 1 5.9L12 16.9 6.8 19.7l1-5.9L3.5 9.7l5.9-.8z" />
  </Svg>
);
export const LeafIcon = () => (
  <Svg><path d="M5 19c0-8 5-13 14-14 0 9-5 14-13 14" /><path d="M5 19c3-4 6-6.5 9-8" /></Svg>
);
export const ShieldIcon = () => (
  <Svg><path d="M12 3.5 5 6v5.5c0 4.4 2.9 7.6 7 9 4.1-1.4 7-4.6 7-9V6z" /><path d="m9 12 2.2 2.2L15.5 10" /></Svg>
);
export const HeartIcon = () => (
  <Svg><path d="M12 20s-7.5-4.6-7.5-10.2A4.3 4.3 0 0 1 12 7.4a4.3 4.3 0 0 1 7.5 2.4C19.5 15.4 12 20 12 20z" /></Svg>
);
export const DropIcon = () => (
  <Svg><path d="M12 3.5s6 6.2 6 10.3a6 6 0 0 1-12 0C6 9.700 12 3.500 12 3.500z" /></Svg>
);
export const FlaskIcon = () => (
  <Svg><path d="M9.500 3.500h5M10.500 3.500v5.700L5 18.500a1.500 1.500 0 0 0 1.300 2.200h11.400a1.500 1.500 0 0 0 1.300-2.200l-5.500-9.300V3.500" /><path d="M7.500 15h9" /></Svg>
);
export const PinIcon = () => (
  <Svg><path d="M12 21s6.500-5.700 6.500-11A6.500 6.500 0 0 0 5.500 10c0 5.300 6.500 11 6.500 11z" /><circle cx="12" cy="10" r="2.300" /></Svg>
);
export const PlusIcon = () => (
  <Svg width="18" height="18"><path d="M12 5v14M5 12h14" /></Svg>
);
export const MinusIcon = () => (
  <Svg width="18" height="18"><path d="M5 12h14" /></Svg>
);
export const TrashIcon = () => (
  <Svg width="18" height="18"><path d="M4 7h16M9 7V4.5h6V7M6.5 7l1 12.5h9l1-12.5" /></Svg>
);
export const ChevronLeftIcon = () => (
  <Svg width="18" height="18"><path d="m14.5 5-7 7 7 7" /></Svg>
);
export const CheckIcon = () => (
  <Svg><path d="m5 12.5 4.5 4.5L19 7.5" /></Svg>
);
