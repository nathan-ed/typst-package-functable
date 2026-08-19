#!/usr/bin/env bash
# Issues #2 and #3, checked on the render.
set -euo pipefail
cd "$(dirname "$0")/.."

if ! python3 -c "import PIL" 2>/dev/null; then
  echo "skip  issues-2-3 (python3 Pillow absent)"
  exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
typst compile tests/test-issues-2-3.typ "$tmp/p-{p}.png" --root . --ppi 200
typst compile tests/test-issues-2-3.typ "$tmp/t.pdf" --root .

status=0

if ! python3 - "$tmp" <<'PY'
import sys
from PIL import Image, ImageChops

d = sys.argv[1]
a = Image.open("%s/p-1.png" % d).convert("L")   # dotted, the default
b = Image.open("%s/p-2.png" % d).convert("L")   # solid, asked for
if a.size != b.size:
    print("FAIL  tailles differentes : %s vs %s" % (a.size, b.size))
    raise SystemExit(1)

diff = ImageChops.difference(a, b)
if diff.getbbox() is None:
    print("FAIL  zero-line dotted et solid rendent la meme chose")
    raise SystemExit(1)

def ink(im):
    w, h = im.size
    px = im.load()
    return sum(1 for y in range(h) for x in range(w) if px[x, y] < 128)

ia, ib = ink(a), ink(b)
# a dotted rule lays down clearly less ink than a solid one over the same run
if ia < ib * 0.995:
    print("ok    zero-line dotted : %d px d'encre contre %d en solid" % (ia, ib))
else:
    print("FAIL  le pointille n'allege pas le trait (%d vs %d px)" % (ia, ib))
    raise SystemExit(1)
PY
then
  status=1
fi

# x-label and the four rows of page 3
p3=$(pdftotext -f 3 -l 3 "$tmp/t.pdf" - | tr -s ' \n' ' ')
case "$p3" in
  *"𝑡"*|*"t"*) echo "ok    x-label : la variable est t" ;;
  *) echo "FAIL  x-label absent de la page 3 ($p3)"; status=1 ;;
esac
case "$p3" in
  *"′′"*|*"″"*|*"''"*) echo "ok    second bloc : f'' present" ;;
  *) echo "FAIL  f'' absent ($p3)"; status=1 ;;
esac

# the second variation row must add a row: the same table without it is shorter
if ! python3 - "$tmp" <<'PY'
import sys
from PIL import Image

def table_height(page):
    im = Image.open("%s/p-%d.png" % (sys.argv[1], page)).convert("L")
    w, h = im.size
    px = im.load()
    rows = [y for y in range(h) if any(px[x, y] < 128 for x in range(0, w, 2))]
    if not rows:
        raise SystemExit("FAIL  page %d vide" % page)
    return max(rows) - min(rows)

with_row = table_height(3)
without = table_height(4)
def ink(page):
    im = Image.open("%s/p-%d.png" % (sys.argv[1], page)).convert("L")
    w, h = im.size
    px = im.load()
    return sum(1 for y in range(h) for x in range(w) if px[x, y] < 128)

status = 0
if with_row <= without + 20:
    print("FAIL  second-variation ne reserve pas de rangee (%d contre %d)" % (with_row, without))
    status = 1
# the reserved row has to hold arrows, not just be empty space
extra = ink(3) - ink(4)
if extra < 300:
    print("FAIL  la rangee reservee est vide (%d px d'encre en plus seulement)" % extra)
    status = 1
if status == 0:
    print("ok    second-variation : rangee de %d px, %d px d'encre de fleches"
          % (with_row - without, extra))
raise SystemExit(status)
PY
then
  status=1
fi

exit $status
