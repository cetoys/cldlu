#!/usr/bin/env sh
# src.html (artifact gövdesi) -> index.html (tek dosya, tarayıcıda doğrudan açılır)
set -e
for g in 01-zam-kahini 02-otobus; do
  src="$g/web/src.html"; out="$g/web/index.html"
  { printf '<!doctype html>\n<html lang="tr">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n<meta name="theme-color" content="#14121a">\n'
    grep -o '<title>.*</title>' "$src" | head -1; printf '\n</head>\n<body>\n'
    sed 's#<title>.*</title>##' "$src"
    printf '\n</body>\n</html>\n'; } > "$out"
  echo "$out $(wc -c < "$out") bytes, gz $(gzip -c "$out" | wc -c)"
done
