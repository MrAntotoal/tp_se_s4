set xlabel "taux"
set ylabel "nb acces"
plot filename index 0 with lines title "fifo",  filename index 1 with lines title "lru", filename index 2 with lines title "horloge",  filename index 3 with lines title "optimal"
pause mouse keypress "press any key and gnuplot will terminate"
