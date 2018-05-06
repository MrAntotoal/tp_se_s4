#!/usr/bin/env bash

if (( $# < 6 ))
then
    echo "erreur arg <puissance min> <puissance max> <moyenne> <puissance case> <puissance page> <fichier de sortie>"
else
    
puissance_min=$1
puissance_max=$2
moyenne=$3
./influance_nbr_acces.sh $puissance_min $puissance_max $moyenne $6 $4 $5
nom=$(echo "-e filename='"$6"' -e sortie='"$6".pdf'")
gnuplot $nom script_gnu/script_nb_acces.gnu
nom_courbe=$(echo $6".pdf")
evince -w $nom_courbe
fi;
