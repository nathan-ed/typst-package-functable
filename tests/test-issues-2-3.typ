// The three things asked for on issues #2 and #3.
//
// p1 (#2) the rule at a zero is dotted: a solid one reads like the double bar
//         of a valeur interdite in a factor row that has no zero there
// p2 (#2) zero-line: "solid" restores the old look
// p3 (#3) x-label, second-variation: f'' signs, f' variations, f' signs,
//         f variations, all in t
#import "../src/lib.typ": *

#set page(width: 13cm, height: 7cm, margin: 0.5cm)

#let two-factors(..extra) = sign-table(
  factors: (
    (label: $x - 1$, zeros: (1,), signs: ("-", "+")),
    (label: $x - 3$, zeros: (3,), signs: ("-", "+")),
  ),
  summary-label: $f(x)$,
  ..extra,
)

#two-factors()
#pagebreak()
#two-factors(zero-line: "solid")
#pagebreak()
#sign-table(
  x-label: $t$,
  signs: ("-", "+"), zeros: (0,), summary-label: $f''(t)$,
  variation: true, variation-label: $f'$,
  second-signs: ("-", "+"), second-summary-label: $f'(t)$,
  second-variation: true, second-variation-label: $f$,
)
#pagebreak()
// same table without the second variation row, the reference for its height
#sign-table(
  x-label: $t$,
  signs: ("-", "+"), zeros: (0,), summary-label: $f''(t)$,
  variation: true, variation-label: $f'$,
  second-signs: ("-", "+"), second-summary-label: $f'(t)$,
)
