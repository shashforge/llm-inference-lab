# 01 - Prefill vs decode, measured on my own machine

First benchmark: Qwen2.5-7B-Instruct, Q4_K_M GGUF (~4.7 GB), llama.cpp on Apple Silicon.
Raw output lives in `benchmarks/`. This note is me explaining what the two numbers mean.

## Numbers

| what | tokens/s |
|---|---|
| pp512 (prefill: process a 512-token prompt) | TODO |
| tg128 (decode: generate 128 tokens, one at a time) | TODO |

Chip: TODO, unified memory: TODO GB, memory bandwidth (spec): TODO GB/s

## 1. Decode ceiling from bandwidth alone

Every generated token needs the whole model read from memory once, so the best case is

    ceiling = memory bandwidth / model size = TODO GB/s / 4.7 GB = TODO tokens/s

Measured tg128 = TODO tokens/s -> TODO % of the ceiling.

## 2. Why prefill is so much faster than decode

TODO (a few sentences in my own words: what prefill does with the same weights that decode cannot)

## 3. Why measured decode sits below the ceiling

TODO (at least two concrete reasons)

## What this changes about how I think about serving

TODO (one or two sentences)
