set terminal pdf
set output courbe_name
set xlabel "nb pages"
set ylabel "taux"
set title "courbe"
plot filename using 2:3 index 0 with lines title "fifo", filename index 1  using 2:3 with lines title "lru" , filename index 2 using 2:3 with lines title "horloge" , filename index 3 using 2:3 with lines title "optimal"

