#!/usr/bin/env bash
# Reproducible build matching the original compile (MiKTeX 2.9, pdfTeX 1.40.14, August 2015).
# Requires podman (or docker: export ENGINE=docker).
#   ./build.sh   → build/natural-metaphors-cgvc2015-final.pdf
# TeX Live 2013 (pdfTeX 1.40.14) with the CGVC 2015 egpubl class/style files from src/.
# openout_any=a: let bibtex write into the absolute output directory /out.
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2013-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out natural-metaphors-cgvc2015-final.tex
