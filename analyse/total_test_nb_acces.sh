#!/usr/bin/env bash

if (( $# < 3 ))
then
    echo "erreur arg <puissance min> <puissance max> <moyenne>"
else
    
puissance_min=$1
puissance_max=$2
moyenne=$3
./influance_nbr_acces.sh $puissance_min $puissance_max $moyenne "resultat_algo_nb_acces"
gnuplot script_nb_acces.gnu
evince -w courbe_nb_acces.pdf
fi;
