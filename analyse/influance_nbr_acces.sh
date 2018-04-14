#!/usr/bin/env bash

if (( $# < 4 ))
then
    echo "erreur arg <puissance min> <puissance max> <moyenne> <fichier de sortie>
le fichier sera formater pour gnuplot"
else
echo "#puissance min : "$1" puissance max :"$2" moyenne :"$3 >> $4
nbr_page=20
nbr_case=10
afficacite=0
puissance=$1
puissance_max=$2
nbr_acces=$(( 2 ** $puissance ))
moyenne=$3
r=0
m=0
i=0
p_prime=$puissance
declare -a liste1
declare -a liste2
declare -a liste3
declare -a liste4
declare -a liste_m1
declare -a liste_m2
declare -a liste_m3
declare -a liste_m4

while (( $puissance <= $puissance_max ))
do
    liste1=("" "")
    liste2=("" "")
    liste3=("" "")
    liste4=("" "")
    echo "puissance : "$(( $puissance ))
    while (( $m < $moyenne ))
    do
	./../bin/generation_fichier $(( 2 ** $puissance )) $nbr_page -1 "entrer"

	r=$(./../bin/test_algo 1 $nbr_case 0 "entrer")
	liste1=("$r" "${liste1[@]}")
	r=$(./../bin/test_algo 2 $nbr_case 0 "entrer")
	liste2=("$r" "${liste2[@]}")
	r=$(./../bin/test_algo 3 $nbr_case 0 "entrer")
	liste3=("$r" "${liste3[@]}")
	r=$(./../bin/test_algo 4 $nbr_case 0 "entrer")
	liste4=("$r" "${liste4[@]}")
	if (( $puissance < 16 ))
	then
		
	    sleep 1
	fi;
	m=$(( $m + 1 ))
	rm entrer
    done;
    val=$(./bin/moyenne ${liste1[@]})
    liste_m1=("${liste_m1[@]}" "$val")
    val=$(./bin/moyenne ${liste2[@]})
    liste_m2=("${liste_m2[@]}" "$val")
    val=$(./bin/moyenne ${liste3[@]})
    liste_m3=("${liste_m3[@]}" "$val")
    val=$(./bin/moyenne ${liste4[@]})
    liste_m4=("${liste_m4[@]}" "$val")
    m=0
    puissance=$(( $puissance + 1 ))
done;


i=1
puissance=$(( $puissance - $p_prime ))
while (( $i <= 4 ))
do
    j=0
    echo "

#algo"$i >> $4
    while (( $j < $puissance ))
    do
	if (( $i == 1 ))
	then 
	    echo ${liste_m1[$j]} $(( 2 ** $(( $p_prime + $j )))) >> $4
	else
	    if (( $i == 2 ))
	    then
		echo ${liste_m2[$j]} $(( 2 ** $(( $p_prime + $j )))) >> $4
	    else
		if (( $i == 3 ))
		then
		    echo ${liste_m3[$j]} $(( 2 ** $(( $p_prime + $j )))) >> $4
		else
		    echo ${liste_m4[$j]} $(( 2 ** $(( $p_prime + $j )))) >> $4
		fi;
	    fi;
	fi;
	j=$(( $j + 1 ))
    done;
    i=$(( $i + 1))
done;

fi;




