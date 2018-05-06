set xlabel "nb cases"
set ylabel "taux"
set title "courbe"
plot filename using 1:3 index 0 with lines title "fifo", filename index 1  using 1:3 with lines title "lru" , filename index 2 using 1:3 with lines title "horloge" , filename index 3 using 1:3 with lines title "optimal"
