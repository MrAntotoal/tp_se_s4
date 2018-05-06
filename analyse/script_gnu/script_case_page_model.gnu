set xlabel "nb case"
set ylabel "nb page"
set zlabel "taux"
set dgrid3d 40,40 qnorm 6
set hidden 
splot filename index 0 with lines title "modele math"
pause mouse keypress "press any key and gnuplot will terminate"
