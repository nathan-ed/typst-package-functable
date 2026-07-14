// functable manual
#import "@preview/functable:0.1.0": sign-table, fun-table

#set document(title: "functable manual", author: "Nathan Scheinmann")
#set page(paper: "a4", margin: (x: 2.5cm, y: 2.5cm))
#set text(size: 11pt, font: "Libertinus Serif")
#set heading(numbering: "1.")
#show link: it => text(fill: rgb("#1a6b99"), it)
#show raw: set text(font: "DejaVu Sans Mono", size: 9pt)

#let example(body) = {
  block(
    width: 100%,
    inset: 1em,
    fill: rgb("#f8f8f8"),
    stroke: (left: 3pt + rgb("#239dad")),
    body
  )
}

#let param-table(rows) = {
  table(
    columns: (auto, auto, auto, 1fr),
    align: (left, left, left, left),
    stroke: 0.5pt + rgb("#ddd"),
    fill: (_, row) => if row == 0 { rgb("#f0f0f0") } else { none },
    [*Parameter*], [*Type*], [*Default*], [*Description*],
    ..rows.flatten()
  )
}

// ── Title ───────────────────────────────────────────────────────────────────
#align(center)[
  #text(size: 24pt, weight: "bold")[functable]
  #v(0.3em)
  #text(size: 13pt, fill: rgb("#555"))[Sign, variation and value tables for French mathematics]
  #v(0.3em)
  #text(size: 10pt, fill: rgb("#888"))[Version 0.1.0 — Nathan Scheinmann — 2026-07-14]
]

#v(1.5em)
#outline(indent: 1.5em)
#pagebreak()

= Overview

`functable` provides two functions for drawing the standard French high-school mathematics tables:

- *`sign-table`* — tableau de signes et de variations (sign/variation/convexity tables in the _tkz-tab_ style)
- *`fun-table`* — tableau de valeurs (function value table)

Both functions support auto-computation: provide a Typst closure and the values or signs are computed automatically.

= `sign-table`

== Basic usage

A sign table contains a header row ($x$), one or more *factor rows* whose signs multiply to give
the *summary row*, an optional *variation row* with diagonal arrows, and optionally a second
block for f'' with a *convexity row*.

#example[
```typst
#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
    (expr: $x + 2$, zeros: ((value: $-2$, approx: -2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)
```
#sign-table(
  factors: (
    (expr: $x - 1$, zeros: ((value: $1$, approx: 1),), signs: ("-", "+")),
    (expr: $x + 2$, zeros: ((value: $-2$, approx: -2),), signs: ("-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)
]

== Parameters

#param-table((
  [`factors`], [`array`], [`()`], [Factor rows (see factor keys below).],
  [`summary-label`], [`content`, `none`], [`none`], [Label for the f' summary row.],
  [`variation`], [`bool`], [`false`], [Show variation row with diagonal arrows.],
  [`variation-label`], [`content`, `none`], [`none`], [Label for the variation row.],
  [`variation-values`], [`array`], [`()`], [Values on the variation row: `(at, label, pos)`.],
  [`bounds`], [`auto`, `none`, `dict`], [`auto`], [Domain bounds in x header. `auto` → $-∞$/$+∞$. `none` hides both. Dict: `(left: ..., right: ...)`.],
  [`start-value`], [`content`, `none`], [`none`], [Function value at the left edge of the variation row.],
  [`start-pos`], [`string`], [`"auto"`], [`"top"`, `"bottom"`, or `"auto"`.],
  [`end-value`], [`content`, `none`], [`none`], [Function value at the right edge of the variation row.],
  [`end-pos`], [`string`], [`"auto"`], [`"top"`, `"bottom"`, or `"auto"`.],
  [`col-width`], [`length`], [`1.5cm`], [Width of each interval column.],
  [`row-height`], [`length`], [`0.9cm`], [Height of sign/factor rows.],
  [`var-row-height`], [`auto`, `length`], [`auto`], [Height of variation and convexity rows. `auto` grows to fit the tallest label.],
  [`second-factors`], [`array`], [`()`], [Factor rows for f''. Same structure as `factors`.],
  [`second-summary-label`], [`content`, `none`], [`none`], [Label for the f'' summary row.],
  [`convexity`], [`bool`], [`false`], [Show convexity row with ∪ (f''>0) and ∩ (f'' < 0).],
  [`convexity-label`], [`content`, `none`], [`none`], [Label for the convexity row.],
  [`hd-fill`], [`color`], [`rgb("#cfe2f3")`], [Fill color when `hd-style: "fill"`.],
  [`hd-style`], [`string`], [`"hatch"`], [HD band style: `"hatch"`, `"fill"`, or `"blank"`.],
  [`show-facteurs`], [`bool`], [`true`], [Show rotated "facteur(s)" strip at the left spanning the factor rows.],
))

=== Factor dictionary keys

Each entry in `factors` or `second-factors` is a dictionary:

#param-table((
  [`expr`], [`content`], [—], [Math expression for the row label (e.g. `$x - 1$`).],
  [`zeros`], [`array`], [`()`], [Zero declarations (see zero keys below).],
  [`signs`], [`array`], [—], [Sign per interval: `"+"`, `"-"`, `""` (blank), `"HD"`. Takes precedence over `fn`.],
  [`fn`], [`function`], [—], [`x => number` for auto-sign inference. Return `none` to mark HD. Used when `signs` is absent.],
  [`interdit`], [`bool`], [`false`], [All zeros of this factor are forbidden values of f (shorthand for `pole: true` on each zero).],
))

=== Zero dictionary keys

Each entry in `zeros`:

#param-table((
  [`value`], [`content`], [—], [Displayed label (e.g. `$1$`, `$sqrt(2)$`).],
  [`approx`], [`float`], [—], [Numeric approximation, used for sorting and test-point computation.],
  [`pole`], [`bool`], [`false`], [Valeur interdite: double bar ‖ in summary/variation/convexity rows; breaks arrows.],
  [`mark`], [`content`, `"bar"`, `"hd"`], [—], [Custom marker in factor and summary rows. `"bar"` draws a double bar; `"hd"` continues the HD hatch through the point.],
  [`summary-mark`], [`content`, `"bar"`, `"hd"`], [—], [Custom marker in the summary row only.],
))

== Variation values

Use `variation-values` to pin function values at interior zeros on the variation row:

```typst
variation-values: (
  (at: 2, label: $-3$),        // auto-positioned
  (at: 5, label: $0$, pos: "top"),   // forced top
)
```

`pos` accepts `"top"`, `"bottom"`, `"arrow"` (centred on the arrow line), or `"auto"`.

== HD (hors-domaine) intervals

Mark an interval as `"HD"` in `signs` (or return `none` from `fn`) for intervals where the
expression does not exist. The interval renders as a hatched band:

#example[
```typst
#sign-table(
  factors: (
    (
      expr: $1 / (2 sqrt(x))$,
      zeros: ((value: $0$, approx: 0, mark: "hd"),),
      fn: x => if x <= 0 { none } else { 1 / (2 * calc.sqrt(x)) },
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $0$, right: $+oo$),
  start-value: $0$, start-pos: "bottom",
)
```
#sign-table(
  factors: (
    (
      expr: $1 / (2 sqrt(x))$,
      zeros: ((value: $0$, approx: 0, mark: "hd"),),
      fn: x => if x <= 0 { none } else { 1 / (2 * calc.sqrt(x)) },
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $0$, right: $+oo$),
  start-value: $0$, start-pos: "bottom",
)
]

`mark: "hd"` continues the hatch *through* a boundary point — use this for a domain
edge where f' is undefined but f continues (e.g. a vertical tangent), as opposed to
`mark: "bar"` which draws an asymptote double bar.

== Poles (valeurs interdites)

Set `pole: true` on a zero to draw a double bar ‖ in the summary, variation and convexity
rows, and to break the variation arrows at that point. Use the `interdit: true` shorthand on
a factor when all its zeros are forbidden values of f:

#example[
```typst
#sign-table(
  factors: (
    (expr: $x + 1$, zeros: ((value: $-1$, approx: -1),), signs: ("-", "+")),
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
```
#sign-table(
  factors: (
    (expr: $x + 1$, zeros: ((value: $-1$, approx: -1),), signs: ("-", "+")),
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
]

== Auto-sign inference with `fn`

When `signs` is omitted and `fn` is provided, the sign in each interval is inferred by
evaluating the function at a test point (midpoint of adjacent zeros for interior intervals,
offset from the boundary zero for outer intervals):

#example[
```typst
// f(x) = x³ − 3x:  f'(x) = 3(x+1)(x−1),  f''(x) = 6x
#sign-table(
  factors: (
    (expr: $x + 1$, zeros: ((value: $-1$, approx: -1),), fn: x => x + 1),
    (expr: $x - 1$, zeros: ((value: $1$,  approx:  1),), fn: x => x - 1),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $+oo$,
  end-value: $+oo$,
  variation-values: ((at: -1, label: $2$), (at: 1, label: $-2$)),
  second-factors: (
    (expr: $6x$, zeros: ((value: $0$, approx: 0),), fn: x => 6 * x),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)
```
#sign-table(
  factors: (
    (expr: $x + 1$, zeros: ((value: $-1$, approx: -1),), fn: x => x + 1),
    (expr: $x - 1$, zeros: ((value: $1$,  approx:  1),), fn: x => x - 1),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $+oo$,
  end-value: $+oo$,
  variation-values: ((at: -1, label: $2$), (at: 1, label: $-2$)),
  second-factors: (
    (expr: $6x$, zeros: ((value: $0$, approx: 0),), fn: x => 6 * x),
  ),
  second-summary-label: $f''(x)$,
  convexity: true,
  convexity-label: $f(x)$,
)
]

`signs` always takes precedence over `fn` if both are provided. Irrational zeros work
correctly because test points are floats (e.g. for a zero at `approx: calc.sqrt(2)`, the
test point in the right interval is `calc.sqrt(2) + 1.0`).

== Simple table without factor strip

Set `show-facteurs: false` to hide the rotated "facteur(s)" label strip. Useful when
there is only one factor row or when the factors are implied by context:

#example[
```typst
#sign-table(
  factors: (
    (zeros: (
      (value: $-2$, approx: -2),
      (value: $1$,  approx:  1),
    ), signs: ("+", "-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  show-facteurs: false,
)
```
#sign-table(
  factors: (
    (zeros: (
      (value: $-2$, approx: -2),
      (value: $1$,  approx:  1),
    ), signs: ("+", "-", "+")),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  show-facteurs: false,
)
]

== Domain boundary (range not in domain)

Use `mark: "hd"` on a zero that lies at a domain boundary (not an asymptote):
the hatch continues *through* the zero point, and the variation arrow starts at that edge.
Combine with a restricted `bounds` to show the function's actual domain:

#example[
```typst
// f(x) = sqrt(x), defined on [0, +∞). f'(x) = 1/(2√x), undefined at 0.
#sign-table(
  factors: (
    (
      expr: $frac(1, 2 sqrt(x))$,
      zeros: ((value: $0$, approx: 0, mark: "hd"),),
      fn: x => if x <= 0 { none } else { 1 / (2 * calc.sqrt(x)) },
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $0$, right: $+oo$),
  start-value: $0$,
  start-pos: "bottom",
)
```
#sign-table(
  factors: (
    (
      expr: $frac(1, 2 sqrt(x))$,
      zeros: ((value: $0$, approx: 0, mark: "hd"),),
      fn: x => if x <= 0 { none } else { 1 / (2 * calc.sqrt(x)) },
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  bounds: (left: $0$, right: $+oo$),
  start-value: $0$,
  start-pos: "bottom",
)
]

A function undefined on an entire interval (e.g. $ln(x^2 - 4)$ undefined for $x in ]-2, 2[$)
uses `"HD"` in `signs` (or `none` from `fn`) for those intervals:

#example[
```typst
// f'(x) = 2x/(x²-4), undefined on ]-2, 2[
#sign-table(
  factors: (
    (
      expr: $2x$,
      zeros: ((value: $0$, approx: 0),),
      signs: ("HD", "+", "+"),
    ),
    (
      expr: $x^2 - 4$,
      zeros: (
        (value: $-2$, approx: -2, pole: true),
        (value: $2$,  approx:  2, pole: true),
      ),
      signs: ("+", "HD", "+"),
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)
```
#sign-table(
  factors: (
    (
      expr: $2x$,
      zeros: ((value: $0$, approx: 0),),
      signs: ("HD", "+", "+"),
    ),
    (
      expr: $x^2 - 4$,
      zeros: (
        (value: $-2$, approx: -2, pole: true),
        (value: $2$,  approx:  2, pole: true),
      ),
      signs: ("+", "HD", "+"),
    ),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
)
]

= `fun-table`

== Basic usage

#example[
```typst
#fun-table(
  x-values: ($0$, $1$, $2$, $3$, $4$),
  rows: (
    (label: $f(x)$, values: ($1$, $3$, $5$, $7$, $9$)),
  ),
)
```
#fun-table(
  x-values: ($0$, $1$, $2$, $3$, $4$),
  rows: (
    (label: $f(x)$, values: ($1$, $3$, $5$, $7$, $9$)),
  ),
)
]

== Parameters

#param-table((
  [`x-values`], [`array`], [`()`], [x column headers. Numbers: displayed in math mode and forwarded to `fn`. Dictionaries `(display, value)`: custom display with numeric value. Content: display-only.],
  [`x-label`], [`content`], [`$x$`], [Label for the x row.],
  [`rows`], [`array`], [`()`], [Function rows (see row keys below).],
  [`col-width`], [`length`], [`1.5cm`], [Column width.],
  [`row-height`], [`length`], [`0.9cm`], [Row height.],
  [`label-width`], [`auto`, `length`], [`auto`], [Label column width. `auto` sizes to fit the widest label.],
  [`stroke`], [`stroke`], [`0.5pt`], [Table border and separator stroke.],
  [`decimals`], [`auto`, `int`], [`auto`], [Decimal places for computed values. `auto` trims trailing zeros.],
))

=== Row dictionary keys

#param-table((
  [`label`], [`content`], [—], [Row label.],
  [`values`], [`array`], [—], [Explicit content cells. Use `none` for blank. Takes precedence over `fn` for non-numeric x.],
  [`fn`], [`function`], [—], [`x => number` used when `x-values` entries are numeric. Return `none` for a blank cell.],
  [`format`], [`function`, `none`], [—], [`number => content` for custom rendering. Default: smart integer/decimal.],
))

== Auto-computed values

Provide numbers in `x-values` and a `fn` closure — values are computed and formatted automatically:

#example[
```typst
#fun-table(
  x-values: (-3, -2, -1, 0, 1, 2, 3),
  rows: (
    (label: $f(x) = x^2 - 1$, fn: x => x * x - 1),
    (label: $g(x) = 2x + 1$,  fn: x => 2 * x + 1),
  ),
)
```
#fun-table(
  x-values: (-3, -2, -1, 0, 1, 2, 3),
  rows: (
    (label: $f(x) = x^2 - 1$, fn: x => x * x - 1),
    (label: $g(x) = 2x + 1$,  fn: x => 2 * x + 1),
  ),
)
]

== Custom display with dictionary x-values

For irrational x values or non-standard display, use `(display: ..., value: ...)` entries:

#example[
```typst
#fun-table(
  x-values: (
    (display: $-pi\/2$, value: -calc.pi / 2),
    (display: $0$,      value: 0.0),
    (display: $pi\/2$,  value: calc.pi / 2),
    (display: $pi$,     value: calc.pi),
  ),
  rows: (
    (label: $sin(x)$, fn: x => calc.sin(x),
     format: x => $#str(calc.round(x, digits: 4))$),
    (label: $cos(x)$, fn: x => calc.cos(x),
     format: x => $#str(calc.round(x, digits: 4))$),
  ),
)
```
#fun-table(
  x-values: (
    (display: $-pi\/2$, value: -calc.pi / 2),
    (display: $0$,      value: 0.0),
    (display: $pi\/2$,  value: calc.pi / 2),
    (display: $pi$,     value: calc.pi),
  ),
  rows: (
    (label: $sin(x)$, fn: x => calc.sin(x),
     format: x => $#str(calc.round(x, digits: 4))$),
    (label: $cos(x)$, fn: x => calc.cos(x),
     format: x => $#str(calc.round(x, digits: 4))$),
  ),
)
]
