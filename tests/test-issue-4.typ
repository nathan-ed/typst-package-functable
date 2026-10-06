// Issue #4: one-sided limits on either side of a valeur interdite.
//
// p1 f(x) = 1/(x-2): -oo / +oo at 2, with limits at the bounds
// p2 f' = (x+1)/(x-2)^2 (signs - + | +): +oo then -oo, right-pos given explicitly
// p3 f' = x/(x-3) (signs + - | +): a centred value at 0, then -oo | -oo
//    — f(x) = x + 3ln|x-3| style, limits both -oo on either side of 3
// p4 second-variation row: auto positions follow the f'' signs
#import "../src/lib.typ": *

#set page(width: 13cm, height: auto, margin: 0.5cm)

#sign-table(
  signs: ("-", "-"),
  zeros: ((value: $2$, approx: 2, pole: true),),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $0$,
  end-value: $0$,
  variation-values: ((at: 2, left: $-oo$, right: $+oo$),),
)

#pagebreak()

#sign-table(
  factors: (
    (expr: $x + 1$, zeros: (-1,), signs: ("-", "+")),
    (expr: $(x - 2)^2$, zeros: (2,), signs: ("+", "+"), interdit: true),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $1$,
  end-value: $1$,
  variation-values: (
    (at: -1, label: $-1/9$),
    (at: 2, left: $+oo$, right: $-oo$, right-pos: "bottom"),
  ),
)

#pagebreak()

#sign-table(
  factors: (
    (expr: $x$, zeros: (0,), signs: ("-", "+")),
    (expr: $x - 3$, zeros: (3,), signs: ("-", "+"), interdit: true),
  ),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  start-value: $-oo$,
  end-value: $+oo$,
  variation-values: (
    (at: 0, label: $3ln 3$),
    (at: 3, left: $-oo$, right: $-oo$),
  ),
)

#pagebreak()

// p4 second-variation row: limits placed from the f'' signs, not the f' ones
#sign-table(
  signs: ("-", "-"),
  zeros: ((value: $1$, approx: 1, pole: true),),
  summary-label: $f'(x)$,
  variation: true,
  variation-label: $f(x)$,
  variation-values: ((at: 1, left: $-oo$, right: $+oo$),),
  second-signs: ("+", "+"),
  second-summary-label: $f''(x)$,
  second-variation: true,
  second-variation-label: $f'(x)$,
  second-variation-values: ((at: 1, left: $+oo$, right: $-oo$),),
)
