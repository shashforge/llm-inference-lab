# llm-inference-lab

Hands-on notes and measurements from my work on LLM inference performance:
prefill vs decode, memory bandwidth limits, batching, KV cache, quantization.
Everything here is measured on my own hardware (Apple Silicon MacBook, NVIDIA
workstation) and written up as I go. Numbers first, explanations second.

## Layout

- `benchmarks/` - raw benchmark output, one dated file per run, with system info
- `notes/` - short write-ups explaining what the numbers mean and why
- `scripts/` - helpers to run and record benchmarks reproducibly

## Setup (macOS)

    brew install llama.cpp
    llama-cli -hf bartowski/Qwen2.5-7B-Instruct-GGUF:Q4_K_M -p "Explain what a KV cache is in two sentences." -n 128
    scripts/bench_llamacpp.sh ~/Library/Caches/llama.cpp/<downloaded>.gguf qwen2.5-7b-q4

## Log

- 2026-08-17 - repo created. First target: llama.cpp baseline on Apple Silicon,
  prefill (pp512) vs decode (tg128), compared against the memory-bandwidth ceiling.
