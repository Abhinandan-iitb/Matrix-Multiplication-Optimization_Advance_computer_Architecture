# Matrix Multiplication Optimization — *The Rancho Way*
![C++](https://img.shields.io/badge/Language-C%2B%2B-blue)
![Architecture](https://img.shields.io/badge/Focus-Computer%20Architecture-orange)
![Optimization](https://img.shields.io/badge/Category-Performance%20Optimization-green)
![Course](https://img.shields.io/badge/CS683-IIT%20Bombay-red)

> *“Optimizing computation by understanding how software interacts with hardware.”*

---

## 🧭 Overview

This project explores **hardware-conscious optimization** for **matrix multiplication** and **embedding operations** — two critical components of modern **Machine Learning** and **Deep Learning** workloads.

It demonstrates how thoughtful use of **cache**, **SIMD**, and **software prefetching** can significantly boost performance on Intel x86 architectures.

---

## 🎯 Objectives

- Understand the impact of **cache hierarchies** and **data locality**.
- Apply **loop-level** and **data-level parallelism** to matrix multiplication.
- Leverage **SIMD (Single Instruction, Multiple Data)** for vectorized computation.
- Implement **software prefetching** to reduce cache miss penalties.
- Optimize **Neural Network** and **Embedding** operations using these techniques.
- Measure performance using:
  - L1/L2/LLC Cache Misses  
  - MPKI (Misses Per Kilo Instructions)  
  - Execution Time & Speedup  
  - Instruction Count  

---

## 🧩 Project Structure

```
pa1-three-geniuses/
├── part1/                         # Matrix Multiplication Optimizations
│   ├── mat_mul/
│   │   ├── matrix.c               # Naive + Optimized implementations
│   │   ├── Makefile               # Build rules
│   │   └── mat_mul_analysis.pdf   # Performance analysis report
│   └── neural_net/                # Neural Network using optimized matmul
│       ├── neural_net.cpp
│       └── neural_net.pdf
│
├── part2/                         # Embedding Operation Optimizations
│   ├── emb.cpp                    # Embedding with prefetching + SIMD
│
├── plots/                         # Performance visualizations
│   ├── speedup_comparison.png
│   ├── cache_effect.pdf
│   └── ...
│
└── README.md                      # This file
```

---

## 🧮 Task 1 — Matrix Multiplication (*The Rancho Way*)

### 🔹 Task 1A: Unroll Baba Unroll
- Implemented **loop unrolling** and **loop reordering**.
- Improved **instruction-level parallelism** and **cache hit rate**.
- Evaluated performance via MPKI and execution time.

### 🔹 Task 1B: Divide Karo, Rule Karo
- Implemented **Tiled Matrix Multiplication** for cache efficiency.
- Experimented with different **tile sizes**.
- Measured:
  - L1-D Cache MPKI vs. Matrix Size  
  - Speedup vs. Matrix Size  

### 🔹 Task 1C: Data Ko Line Mein Lagao
- Introduced **SIMD (SSE/AVX/AVX512)** vectorization.
- Used Intel intrinsics (`_m128d`, `_m256d`, `_m512d`).
- Observed up to **2–3× speedup** through parallel arithmetic.

### 🔹 Task 1D: Rancho’s Final Year Project
- Combined **Tiling + SIMD + Loop Unrolling**.
- Demonstrated **synergistic performance improvement** over individual methods.

### 🔹 Task 1E: Confusion hi Confusion Hai !!
- Applied optimized matrix multiplication inside a **Neural Network**.
- Measured end-to-end inference speedup.

---

## 💡 Task 2 — Embed It (Embedding Optimization)

### 🔹 Task 2A: Software Prefetching
- Used `_mm_prefetch` and `_builtin_prefetch` for memory access optimization.
- Tuned:
  - **Prefetch Distance**
  - **Cache Fill Level**
- Analyzed **L1/L2/LLC Misses**, execution time, and **speedup**.

### 🔹 Task 2B: SIMD
- Parallelized embedding summations using **SIMD intrinsics**.
- Compared multiple **SIMD widths** (64/128/256 bits).
- Evaluated **instruction count** and **execution time** improvements.

### 🔹 Task 2C: Software Prefetching + SIMD
- Combined both optimizations.
- Achieved the **highest speedup** for large embedding tables.
- Plotted performance trends for all methods.

---

## 📊 Results & Insights

| Technique | Focus | Typical Speedup | Observation |
|------------|--------|----------------|--------------|
| Loop Unrolling | Instruction-level parallelism | ~1.2× | Reduced loop overhead |
| Tiling | Cache reuse | ~1.8× | Improved spatial locality |
| SIMD | Data-level parallelism | ~2–3× | Parallel multiply-add |
| Prefetching | Memory latency hiding | ~1.3× | Fewer cache stalls |
| Combined (Tiling + SIMD + Prefetch) | Full-stack optimization | ~4–5× | Hardware-aware synergy |

---

## 🧰 Tools & Environment

- **Language:** C / C++
- **Profiler:** [`perf`](https://perfwiki.github.io/main/)
- **Hardware:** Intel x86 CPU with AVX / AVX2 / AVX512 support
- **Libraries:**
  - `<immintrin.h>` for SIMD intrinsics
  - GCC/Clang (compile with `-O0` for fair measurement)

---

## 📈 Sample Visualizations

| Plot | Description |
|------|--------------|
| ![Speedup Comparison](plots/speedup_comparison.png) | Speedup vs Matrix Size |
| ![Cache Effect](plots/cache_effect.pdf) | Cache Misses vs Tile Size |

---

## 🧠 Key Takeaways

1. **Cache-aware programming** greatly improves data reuse.  
2. **SIMD** enables parallel arithmetic on multiple elements per cycle.  
3. **Software prefetching** hides memory latency by anticipating data access.  
4. **Combining techniques** delivers super-linear performance benefits.  
5. These optimizations directly apply to **ML and DL kernels** like GEMM, convolution, and embedding lookup.

---

## ⚙️ How to Run

```bash
# Compile all targets
make

# Run baseline implementation
./matrix_naive

# Run optimized implementation
./matrix_optimized

# Profile with perf
perf stat -e cache-misses,cache-references ./matrix_optimized
```

---

## 👨‍💻 Authors

**Team:** OneCpi
**Course:** CS683 — Advanced Computer Architecture
**Institution:** Indian Institute of Technology, Bombay  
**Instructor:** Prof. Biswabandan Panda

---

## 🧾 References

- [Intel Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide)
- [perf Wiki](https://perfwiki.github.io/main/)
- [CASPER Group](https://casper-iitb.github.io/)

---

> 📘 *This project demonstrates how a deep understanding of computer architecture enables smarter, faster, and more efficient software — especially in ML and HPC workloads.*
