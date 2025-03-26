#!/bin/bash

ROOT="$(realpath "$(dirname "$0")")" # on MacOS, we need this to be an absolute path

podman run --rm \
  --mount=type=bind,source="$ROOT",destination=/work \
  --workdir /work \
  registry.gitlab.com/islandoftex/images/texlive:TL2025-2025-03-23-full \
  latexmk -xelatex -pdf -recorder \
  -latexoption="-interaction nonstopmode -shell-escape" \
  -outdir=build thesis.tex "$@"
