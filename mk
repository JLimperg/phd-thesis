#!/bin/bash

ROOT="$(realpath "$(dirname "$0")")"

runtime=""
for r in finch podman docker; do
  if command -v "$r" &>/dev/null; then
    runtime="$r"
    break
  fi
done

if [ -z "$runtime" ]; then
  echo "Error: No container runtime found (docker, podman, or finch)" >&2
  exit 1
fi

"$runtime" run --rm \
  --mount=type=bind,source="$ROOT",destination=/work \
  --workdir /work \
  registry.gitlab.com/islandoftex/images/texlive:TL2025-2026-01-18-full \
  latexmk -xelatex -recorder \
  -latexoption="-interaction nonstopmode -shell-escape" \
  -outdir=build thesis.tex $@
