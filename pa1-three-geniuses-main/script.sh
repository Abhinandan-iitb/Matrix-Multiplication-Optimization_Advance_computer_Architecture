#!/bin/bash

OUTPUT_CSV="perf_results.csv"
OUTPUT_PNG="mpki_graph.png"

# Write CSV header
echo "Size,Instructions,L1D_Misses,L1D_MPKI,L1I_Misses,L1I_MPKI" > $OUTPUT_CSV

# Loop over input sizes
for N in 250 275 300 325 350 375 400 425 450 475 500 525 550 552 560 568 575 576 600 625 650 675 700 725 750; do
    echo "Running size $N..."
    
    # Run perf and capture output
    PERF_OUT=$(perf stat -e instructions,L1-dcache-load-misses,L1-icache-load-misses ./test $N 2>&1 > /dev/null)
    
    # Extract values
    INSTR=$(echo "$PERF_OUT" | grep instructions | awk '{print $1}' | tr -d ',')
    L1D_MISS=$(echo "$PERF_OUT" | grep L1-dcache-load-misses | awk '{print $1}' | tr -d ',')
    L1I_MISS=$(echo "$PERF_OUT" | grep L1-icache-load-misses | awk '{print $1}' | tr -d ',')
    
    # Compute MPKI
    L1D_MPKI=$(echo "scale=6; $L1D_MISS / $INSTR * 1000" | bc)
    L1I_MPKI=$(echo "scale=6; $L1I_MISS / $INSTR * 1000" | bc)
    
    # Append to CSV
    echo "$N,$INSTR,$L1D_MISS,$L1D_MPKI,$L1I_MISS,$L1I_MPKI" >> $OUTPUT_CSV
done

echo "Data collection complete. CSV saved to $OUTPUT_CSV"

# Plot using gnuplot
gnuplot <<EOF
set terminal pngcairo size 800,600 enhanced font 'Arial,12'
set output "$OUTPUT_PNG"
set datafile separator ","
set title "Matrix Multiplication MPKI vs Input Size"
set xlabel "Matrix Size (N)"
set ylabel "MPKI (Misses per Kilo Instructions)"
set grid
plot "$OUTPUT_CSV" using 1:4 with linespoints lt rgb "blue" lw 2 pt 7 title "L1-D MPKI"
# , \
#      "$OUTPUT_CSV" using 1:6 with linespoints lt rgb "red" lw 2 pt 7 title "L1-I MPKI"
EOF

echo "Graph saved as $OUTPUT_PNG"
