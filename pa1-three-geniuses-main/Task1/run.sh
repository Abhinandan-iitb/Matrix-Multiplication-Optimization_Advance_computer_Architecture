#!/bin/bash

OUTPUT_DIR="./outputs"
mkdir -p "$OUTPUT_DIR"

OUTPUT_CSV="$OUTPUT_DIR/tiling_16_perf_vs_size.csv"
OUTPUT_PNG="$OUTPUT_DIR/tiling_16_perf_vs_size.png"

# CSV header
echo "Size,NormalizedPerformance" > "$OUTPUT_CSV"

# Array of matrix sizes
SIZES=(100 200 300 400 500 600 700 800 900 1000 1200 1500 1700 2000)

for N in "${SIZES[@]}"; do
    echo "Running matrix size $N ..."
    
    # Run program and capture output
    OUTPUT=$(./mat_mul/tiling "$N")
    
    # Extract normalized performance
    NORM_PERF=$(echo "$OUTPUT" | grep "Normalized performance:" | awk '{print $3}')
    
    # Debug print
    echo "Size: $N, Normalized Performance: $NORM_PERF"
    
    # Append to CSV
    echo "$N,$NORM_PERF" >> "$OUTPUT_CSV"
done

echo "Data collection complete. CSV saved to $OUTPUT_CSV"

# Plot using gnuplot
gnuplot <<EOF
set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output "$OUTPUT_PNG"
set datafile separator ","
set title "Normalized Performance vs Matrix Size"
set xlabel "Matrix Size (N)"
set ylabel "Normalized Performance"
set grid
plot "$OUTPUT_CSV" using 1:2 with linespoints lt rgb "blue" lw 2 pt 7 title "Normalized Performance"
EOF

echo "Graph saved as $OUTPUT_PNG"
