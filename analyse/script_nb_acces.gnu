set terminal pdf
set output "courbe_nb_acces.pdf"
plot "resultat_algo_nb_acces" index 0 with lines title "fifo",  "resultat_algo_nb_acces" index 1 with lines title "lru", "resultat_algo_nb_acces" index 2 with lines title "horloge",  "resultat_algo_nb_acces" index 3 with lines title "optimal"
