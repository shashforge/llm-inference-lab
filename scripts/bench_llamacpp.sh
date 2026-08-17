#!/usr/bin/env bash
# Run llama-bench on a GGUF model and save the result together with system info,
# so every number in benchmarks/ can be traced back to the exact machine and file.
#
# Usage:  scripts/bench_llamacpp.sh <model.gguf> [label]
# Output: benchmarks/YYYY-MM-DD_<os>_<label>.md   (also printed to the terminal)
#
# pp512 = prompt processing (prefill) tokens/s, tg128 = text generation (decode) tokens/s.

set -euo pipefail

MODEL="${1:?usage: $0 <model.gguf> [label]}"
LABEL="${2:-$(basename "$MODEL" .gguf)}"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
OUT="benchmarks/$(date +%F)_${OS}_${LABEL}.md"

mkdir -p benchmarks

{
  echo "# ${LABEL} - $(date +%F)"
  echo
  echo "## System"
  echo '```'
  if [ "$OS" = "darwin" ]; then
    system_profiler SPHardwareDataType | grep -E "Chip|Memory|Cores"
  else
    lscpu | grep -E "Model name|^CPU\(s\)"
    nvidia-smi --query-gpu=name,memory.total --format=csv 2>/dev/null || true
  fi
  echo '```'
  echo
  echo "## Model"
  echo "- file: $(basename "$MODEL")"
  echo "- size: $(du -h "$MODEL" | cut -f1)"
  echo
  echo "## llama-bench (pp512 = prefill, tg128 = decode)"
  echo '```'
  llama-bench -m "$MODEL" -p 512 -n 128
  echo '```'
} | tee "$OUT"

echo
echo "saved: $OUT"
