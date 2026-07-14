/// Comprehensive tests for sign-table
#import "@local/functable:0.1.0": sign-table, fun-table

#set page(width: 22cm, height: auto, margin: 1cm)
#set text(size: 10pt)

#let section(title) = [
  #v(0.6em)
  *#title*
  #v(0.2em)
]

// ─── 1. Single factor, no summary ─────────────────────────────────────────────
#section[1. Single factor, no summary label]

#sign-table(
  factors: (
    (
      expr: $x - 2$,
      zeros: ((value: $2$, approx: 2),),
      signs: ("-", "+"),
    ),
  ),
)

// ─── 2. Two factors + summary ─────────────────────────────────────────────────
#section[2. Two factors + f'(x) summary]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
    (expr: $x + 2$, zeros: ((value: $-2$, approx: -2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
)

// ─── 3. Three factors, sign product ───────────────────────────────────────────
#section[3. Three factors — sign product changes twice]

#sign-table(
  factors: (
    (expr: $x + 3$, zeros: ((value: $-3$, approx: -3),), signs: ("-", "+")),
    (expr: $x$,     zeros: ((value: $0$,  approx: 0),),  signs: ("-", "+")),
    (expr: $x - 2$, zeros: ((value: $2$,  approx: 2),),  signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
)

// ─── 4. Variation row ─────────────────────────────────────────────────────────
#section[4. Variation row with arrows]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
    (expr: $x + 2$, zeros: ((value: $-2$, approx: -2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)

// ─── 5. Variation with start/end values ───────────────────────────────────────
#section[5. Variation with start/end function values]

#sign-table(
  factors: (
    (expr: $2x - 4$, zeros: ((value: $2$, approx: 2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $+oo$,
  end-value: $+oo$,
  variation-values: (
    (at: 2, label: $-3$),
  ),
)

// ─── 6. Variation with interior values ────────────────────────────────────────
#section[6. Variation with a local max and min value labelled]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
    (expr: $x + 2$, zeros: ((value: $-2$, approx: -2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $-oo$,
  end-value: $+oo$,
  variation-values: (
    (at: -2, label: $5$, pos: "top"),
    (at:  1, label: $-4$, pos: "bottom"),
  ),
)

// ─── 7. Pole / valeur interdite ───────────────────────────────────────────────
#section[7. Pole (valeur interdite) with double bar and broken arrow]

#sign-table(
  factors: (
    (
      expr: $x - 3$,
      zeros: ((value: $3$, approx: 3, pole: true),),
      signs: ("-", "+"),
    ),
  ),
  summary-label: $f(x)$,
  variation: true,
  variation-label: $f$,
  bounds: (left: $0$, right: $+oo$),
  start-value: $f(0)$,
)

// ─── 8. interdit shorthand ────────────────────────────────────────────────────
#section[8. interdit: true shorthand for forbidden values]

#sign-table(
  factors: (
    (
      expr: $x(x-2)$,
      zeros: (
        (value: $0$, approx: 0),
        (value: $2$, approx: 2),
      ),
      signs: ("+", "-", "+"),
      interdit: true,
    ),
  ),
  summary-label: $f(x)$,
)

// ─── 9. HD (hors-domaine) intervals ───────────────────────────────────────────
#section[9. HD intervals — hatched bands]

#sign-table(
  factors: (
    (
      expr: $sqrt(x)$,
      zeros: ((value: $0$, approx: 0),),
      signs: ("HD", "+"),
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $-oo$, right: $+oo$),
)

// ─── 10. hd-style: fill ───────────────────────────────────────────────────────
#section[10. HD with fill style instead of hatch]

#sign-table(
  factors: (
    (
      expr: $sqrt(x-1)$,
      zeros: ((value: $1$, approx: 1),),
      signs: ("HD", "+"),
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  hd-style: "fill",
  hd-fill: rgb("#fde68a"),
)

// ─── 11. hd-style: blank ──────────────────────────────────────────────────────
#section[11. HD with no fill (blank)]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("HD", "+")),
  ),
  summary-label: $f'(x)$,
  hd-style: "blank",
)

// ─── 12. mark: "hd" — domain edge without asymptote ──────────────────────────
#section[12. mark: "hd" — f' undefined at a boundary point (no asymptote)]

#sign-table(
  factors: (
    (
      expr: $1/(2 sqrt(x))$,
      zeros: ((value: $0$, approx: 0, mark: "hd"),),
      signs: ("HD", "+"),
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $0$, right: $+oo$),
  start-value: $0$,
  start-pos: "bottom",
)

// ─── 13. summary-mark override ────────────────────────────────────────────────
#section[13. summary-mark: "bar" — pole in f but not in factor]

#sign-table(
  factors: (
    (
      expr: $x^2 - 1$,
      zeros: (
        (value: $-1$, approx: -1),
        (value: $1$,  approx: 1, summary-mark: "bar"),
      ),
      signs: ("+", "-", "+"),
    ),
  ),
  summary-label: $f(x)$,
)

// ─── 14. Custom bounds ────────────────────────────────────────────────────────
#section[14. Custom domain bounds]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $0$, right: $2^-$),
  start-value: $-3$,
  end-value: $+oo$,
)

// ─── 15. bounds: none ─────────────────────────────────────────────────────────
#section[15. No bound labels]

#sign-table(
  factors: (
    (expr: $x$, zeros: ((value: $0$, approx: 0),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  bounds: none,
)

// ─── 16. Second derivative block (f'' + f') ───────────────────────────────────
#section[16. f' block + f'' block (second-factors)]

#sign-table(
  factors: (
    (expr: $2x - 2$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  second-factors: (
    (expr: $2$, zeros: (), signs: ("+")),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)

// ─── 17. Full: f' + variation + f'' + convexity ───────────────────────────────
#section[17. Full table: polynomial with local extremum and inflection point]

#sign-table(
  factors: (
    (expr: $3x^2 - 3$, zeros: (
      (value: $-1$, approx: -1),
      (value: $1$,  approx:  1),
    ), signs: ("+", "-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $+oo$,
  end-value: $+oo$,
  variation-values: (
    (at: -1, label: $2$,  pos: "top"),
    (at:  1, label: $-2$, pos: "bottom"),
  ),
  second-factors: (
    (expr: $6x$, zeros: ((value: $0$, approx: 0),), signs: ("-", "+")),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)

// ─── 18. Shared zero across f' and f'' blocks ─────────────────────────────────
#section[18. Zero shared by f' and f'' factors (deduplication)]

#sign-table(
  factors: (
    (expr: $(x-1)^2$, zeros: ((value: $1$, approx: 1),), signs: ("+", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  second-factors: (
    (expr: $2(x-1)$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)

// ─── 19. No facteurs strip (show-facteurs: false) ────────────────────────────
#section[19. show-facteurs: false — no rotated strip]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
    (expr: $x + 1$, zeros: ((value: $-1$, approx: -1),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  show-facteurs: false,
)

// ─── 20. Custom column/row dimensions ────────────────────────────────────────
#section[20. Custom col-width and row-height]

#sign-table(
  factors: (
    (expr: $x - 2$, zeros: ((value: $2$, approx: 2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  col-width: 2.5cm,
  row-height: 1.2cm,
  var-row-height: 2cm,
)

// ─── 21. Rational function — quotient with pole ───────────────────────────────
#section[21. Rational function f = (x+1)/(x-2): pole at 2, zero at -1]

#sign-table(
  factors: (
    (
      expr: $x + 1$,
      zeros: ((value: $-1$, approx: -1),),
      signs: ("-", "+"),
    ),
    (
      expr: $x - 2$,
      zeros: ((value: $2$, approx: 2, pole: true),),
      signs: ("-", "+"),
    ),
  ),
  summary-label: $f(x)$,
  variation: true,
  variation-label: $f(x)$,
)

// ─── 22. Long label — label column auto-widens ────────────────────────────────
#section[22. Long label expression auto-widens label column]

#sign-table(
  factors: (
    (
      expr: $frac(x^2 + 2x - 3, x - 1)$,
      zeros: ((value: $0$, approx: 0),),
      signs: ("-", "+"),
    ),
  ),
  summary-label: $f'(x)$,
)

// ─── 23. Tall bound labels (display fractions in header) ──────────────────────
#section[23. Tall header — display fraction as bound value]

#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  bounds: (left: $-frac(3, 2)$, right: $frac(7, 4)$),
)

// ─── 24. Multiple poles ───────────────────────────────────────────────────────
#section[24. Two poles — arrows broken at both]

#sign-table(
  factors: (
    (
      expr: $(x-1)(x+2)$,
      zeros: (
        (value: $-2$, approx: -2, pole: true),
        (value: $1$,  approx:  1, pole: true),
      ),
      signs: ("+", "-", "+"),
    ),
  ),
  summary-label: $f(x)$,
  variation: true,
  variation-label: $f(x)$,
)

// ─── 25. Only variation row, no factor rows ───────────────────────────────────
#section[25. Sign table used as a standalone variation row (no factors)]

#sign-table(
  factors: (
    (zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $-3$,
  end-value: $+oo$,
  variation-values: ((at: 1, label: $0$),),
)

// ─── 26. Only convexity, no variation ────────────────────────────────────────
#section[26. Convexity row without a variation row]

#sign-table(
  second-factors: (
    (expr: $2x - 1$, zeros: ((value: $1/2$, approx: 0.5),), signs: ("-", "+")),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)

// ─── 27. variation-values pos: "arrow" ───────────────────────────────────────
#section[27. variation-values with pos: "arrow" (label on the arrow line)]

#sign-table(
  factors: (
    (expr: $x - 2$, zeros: ((value: $2$, approx: 2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $3$,
  end-value: $7$,
  variation-values: ((at: 2, label: $0$, pos: "arrow"),),
)

// ─── 28. HD in second block ───────────────────────────────────────────────────
#section[28. HD in second-factors block]

#sign-table(
  factors: (
    (expr: $2x$, zeros: ((value: $0$, approx: 0),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  second-factors: (
    (expr: $x^(-1/2)$, zeros: ((value: $0$, approx: 0, mark: "hd"),), signs: ("HD", "+")),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
  bounds: (left: $0$, right: $+oo$),
)

// ─── 29. No zeros ─────────────────────────────────────────────────────────────
#section[29. Single sign throughout — no zeros]

#sign-table(
  factors: (
    (expr: $e^x$, zeros: (), signs: ("+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $0$,
  end-value: $+oo$,
)

// ─── 30. fun-table ────────────────────────────────────────────────────────────
#section[30. fun-table: simple function values table]

#fun-table(
  x-values: ($-2$, $-1$, $0$, $1$, $2$, $3$),
  rows: (
    (label: $f(x)$, values: ($7$, $3$, $1$, $1$, $3$, $7$)),
  ),
)

// ─── 31. fun-table with multiple rows ─────────────────────────────────────────
#section[31. fun-table with f(x) and g(x) rows]

#fun-table(
  x-values: ($0$, $pi/6$, $pi/4$, $pi/3$, $pi/2$),
  rows: (
    (label: $sin(x)$, values: ($0$, $1/2$, $frac(sqrt(2), 2)$, $frac(sqrt(3), 2)$, $1$)),
    (label: $cos(x)$, values: ($1$, $frac(sqrt(3), 2)$, $frac(sqrt(2), 2)$, $1/2$, $0$)),
  ),
)

// ─── 32. fun-table with blanks (none values) ──────────────────────────────────
#section[32. fun-table with blank cells (none)]

#fun-table(
  x-values: ($-1$, $0$, $1$, $2$),
  rows: (
    (label: $f(x)$, values: (none, $0$, none, $4$)),
  ),
)

// ─── 33. fun-table with custom dimensions and label ──────────────────────────
#section[33. fun-table with custom col-width, row-height, and x-label]

#fun-table(
  x-label: [$t$ (s)],
  x-values: ($0$, $1$, $2$, $3$, $4$),
  rows: (
    (label: [$v(t)$ (m/s)], values: ($0$, $9.8$, $19.6$, $29.4$, $39.2$)),
  ),
  col-width: 2cm,
  row-height: 1.1cm,
)

// ─── 34. fun-table with fn: auto-computed values ─────────────────────────────
#section[34. fun-table with fn: auto-computation from numeric x-values]

#fun-table(
  x-values: (-3, -2, -1, 0, 1, 2, 3),
  rows: (
    (label: $f(x) = x^2 - 1$, fn: x => x * x - 1),
  ),
)

// ─── 35. fun-table fn: float results with default trimming ───────────────────
#section[35. fun-table fn: float x-values with auto decimal trimming]

#fun-table(
  x-values: (0.0, 0.5, 1.0, 1.5, 2.0),
  rows: (
    (label: $f(x) = 2x$, fn: x => 2 * x),
    (label: $g(x) = x^2$, fn: x => x * x),
  ),
)

// ─── 36. fun-table fn: custom format ─────────────────────────────────────────
#section[36. fun-table fn: custom format function (returns none for undefined)]

#fun-table(
  x-values: (-2, -1, 0, 1, 2),
  rows: (
    (
      label: $f(x) = 1/x$,
      fn: x => if x == 0 { none } else { 1 / x },
      format: x => $#str(calc.round(x, digits: 2))$,
    ),
  ),
)

// ─── 37. fun-table: mixed — fn + explicit values in same table ────────────────
#section[37. fun-table: mix of fn row and explicit values row]

#fun-table(
  x-values: (-2, -1, 0, 1, 2),
  rows: (
    (label: $f(x)$, fn: x => x * x),
    (label: $g(x)$, values: ($3$, $1$, $0$, $1$, $3$)),
  ),
)

// ─── 38. fun-table: dict x-values with custom display ────────────────────────
#section[38. fun-table: dictionary x-values with custom display and numeric fn]

#fun-table(
  x-values: (
    (display: $-pi\/2$, value: -calc.pi / 2),
    (display: $0$,      value: 0.0),
    (display: $pi\/2$,  value: calc.pi / 2),
    (display: $pi$,     value: calc.pi),
  ),
  rows: (
    (label: $sin(x)$, fn: x => calc.sin(x), format: x => $#str(calc.round(x, digits: 4))$),
    (label: $cos(x)$, fn: x => calc.cos(x), format: x => $#str(calc.round(x, digits: 4))$),
  ),
)

// ─── 39. fun-table: decimals parameter ───────────────────────────────────────
#section[39. fun-table: decimals: 3 for consistent decimal places]

#fun-table(
  x-values: (0, 1, 2, 3, 4),
  rows: (
    (label: $sqrt(x)$, fn: x => calc.sqrt(x)),
  ),
  decimals: 3,
)

// ════ sign-table with fn: auto-sign tests ═══════════════════════════════════

// ─── 40. sign-table: fn auto-signs, single factor ────────────────────────────
#section[40. sign-table with fn: auto-computed signs (single factor)]

#sign-table(
  factors: (
    (
      expr: $x - 2$,
      zeros: ((value: $2$, approx: 2),),
      fn: x => x - 2,
      // no signs: field — auto-computed from fn
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)

// ─── 41. sign-table: fn auto-signs, two factors ───────────────────────────────
#section[41. sign-table with fn: two factors, signs auto-inferred]

#sign-table(
  factors: (
    (
      expr: $x - 1$,
      zeros: ((value: $1$, approx: 1),),
      fn: x => x - 1,
    ),
    (
      expr: $x + 2$,
      zeros: ((value: $-2$, approx: -2),),
      fn: x => x + 2,
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $-oo$,
  end-value: $+oo$,
  variation-values: (
    (at: -2, label: $5$),
    (at:  1, label: $-4$),
  ),
)

// ─── 42. sign-table: irrational zero, fn auto-signs ──────────────────────────
#section[42. sign-table with fn: irrational zero sqrt(2), auto-sign inference]

#sign-table(
  factors: (
    (
      expr: $x - sqrt(2)$,
      zeros: ((value: $sqrt(2)$, approx: calc.sqrt(2)),),
      fn: x => x - calc.sqrt(2),
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)

// ─── 43. sign-table: fn with three zeros ──────────────────────────────────────
#section[43. sign-table with fn: polynomial with three roots]

// f'(x) = (x+2)(x-1)(x-3)
#sign-table(
  factors: (
    (
      expr: $x + 2$,
      zeros: ((value: $-2$, approx: -2),),
      fn: x => x + 2,
    ),
    (
      expr: $x - 1$,
      zeros: ((value: $1$, approx: 1),),
      fn: x => x - 1,
    ),
    (
      expr: $x - 3$,
      zeros: ((value: $3$, approx: 3),),
      fn: x => x - 3,
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $-oo$,
  end-value: $+oo$,
)

// ─── 44. sign-table: fn with HD return (none) ────────────────────────────────
#section[44. sign-table with fn: returning none for HD intervals]

// sqrt(x-1) is defined only for x >= 1
#sign-table(
  factors: (
    (
      expr: $1 / (2 sqrt(x-1))$,
      zeros: ((value: $1$, approx: 1, mark: "hd"),),
      fn: x => if x <= 1 { none } else { 1 / (2 * calc.sqrt(x - 1)) },
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $1$, right: $+oo$),
  start-value: $f(1)$,
)

// ─── 45. sign-table: fn fully automatic — rational function ──────────────────
#section[45. Fully automatic rational function: f = (x+1)/(x-2)]

// f'(x) sign determined by numerator and denominator
#sign-table(
  factors: (
    (
      expr: $x + 1$,
      zeros: ((value: $-1$, approx: -1),),
      fn: x => x + 1,
    ),
    (
      expr: $x - 2$,
      zeros: ((value: $2$, approx: 2, pole: true),),
      fn: x => if x == 2 { none } else { x - 2 },
    ),
  ),
  summary-label: $f(x)$,
  variation: true,
  variation-label: $f(x)$,
)

// ─── 46. sign-table: second-factors with fn ───────────────────────────────────
#section[46. Full analysis table with fn everywhere (polynomial)]

// f(x) = x^3 - 3x, f'(x) = 3x^2 - 3 = 3(x+1)(x-1), f''(x) = 6x
#sign-table(
  factors: (
    (
      expr: $x + 1$,
      zeros: ((value: $-1$, approx: -1),),
      fn: x => x + 1,
    ),
    (
      expr: $x - 1$,
      zeros: ((value: $1$, approx: 1),),
      fn: x => x - 1,
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $+oo$,
  end-value: $+oo$,
  variation-values: (
    (at: -1, label: $2$),
    (at:  1, label: $-2$),
  ),
  second-factors: (
    (
      expr: $6x$,
      zeros: ((value: $0$, approx: 0),),
      fn: x => 6 * x,
    ),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)
