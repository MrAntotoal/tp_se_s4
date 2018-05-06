#!/usr/bin/env bash

if (( $# != 7 ))
then
    echo "erreur arg <puissance min case> <puissance max case> <puissance min page> <puissance max page> <puissance_acces> <moyenne> <fichier de sortie>
le fichier sera formater pour gnuplot"
else
echo "#puissance min case : "$1" puissance max case : "$2" puissance min page : "$3" puissance max page : "$4" puissance acces : "$5" moyenne : "$6 >> $7

afficacite=0
puissance_case=$1
puissance_case_max=$2
puissance_page=$3
puissance_page_max=$4
moyenne=$6
r=0
m=0
declare -a liste1
declare -a liste2
declare -a liste3
declare -a liste4
declare -a liste_m1
declare -a liste_m2
declare -a liste_m3
declare -a liste_m4

i=$puissance_case
j=$puissance_page
seed=0
while (( $i <= $puissance_case_max ))
do
    echo "puissance case : "$i
    j=$puissance_page
    while (( $j <= $puissance_page_max ))
    do
	liste1=("" "")
	liste2=("" "")
	liste3=("" "")
	liste4=("" "")
	m=0
	while (( m < $moyenne ))
	do
	    ./../bin/generation_fichier $(( 2 ** $5 )) $(( 2 ** $j )) -1 "entrer" $seed
	    r=$(./../bin/test_algo 1 $(( 2 ** $i )) 0 "entrer")
	    #echo $r "case"$i "page"$j
	    liste1=("$r" "${liste1[@]}")
	    r=$(./../bin/test_algo 2 $(( 2 ** $i )) 0 "entrer")
	    liste2=("$r" "${liste2[@]}")
	    r=$(./../bin/test_algo 3 $(( 2 ** $i )) 0 "entrer")
	    liste3=("$r" "${liste3[@]}")
	    r=$(./../bin/test_algo 4 $(( 2 ** $i )) 0 "entrer")
	    liste4=("$r" "${liste4[@]}")
	    seed=$(( $seed + 1 ))
	    #if (( $5 < 16 ))
	    #then
		
		#sleep 1
	    #fi;
	    rm entrer
	    m=$(( $m + 1 ))
	done;
	#echo ${liste1[@]}
	val=$(./../bin/moyenne ${liste1[@]})
	#echo "moyenne" $val "case"$i "page"$j
	liste_m1=("${liste_m1[@]}" "$val")
	#echo "liste :"${liste_m1[@]}""
	val=$(./../bin/moyenne ${liste2[@]})
	liste_m2=("${liste_m2[@]}" "$val")
	val=$(./../bin/moyenne ${liste3[@]})
	liste_m3=("${liste_m3[@]}" "$val")
	val=$(./../bin/moyenne ${liste4[@]})
	liste_m4=("${liste_m4[@]}" "$val")
	j=$(( $j + 1 ))
    done;
    i=$(( $i +1 ))
done;


i=$puissance_case
j=$puissance_page
a=1
while (( $a <= 4 ))
do
    i=$puissance_case
    echo "

#algo"$a >> $7
    while (( $i <= $puissance_case_max ))
    do
	j=$puissance_page
	while (( $j <= $puissance_page_max ))
	do

	    #=$(( $(( $i - $puissance_case )) * $(( $j - $puissance_page )) ))
	    index=$(( $(( $(( $i - $puissance_case )) * $(( $puissance_page_max + 1 ))  )) + $(( $j - $puissance_page ))  ))
	    if (( $a == 1 ))
	    then
		echo $(( 2 ** $i )) $(( 2 ** $j )) ${liste_m1[$index]} >> $7
	    else
		if (( $a == 2 ))
		then
		    echo $(( 2 ** $i )) $(( 2 ** $j )) ${liste_m2[$index]} >> $7
		else
		    if (( $a == 3 ))
		    then
			echo $(( 2 ** $i )) $(( 2 ** $j )) ${liste_m3[$index]} >> $7
		    else
			echo $(( 2 ** $i )) $(( 2 ** $j )) ${liste_m4[$index]} >> $7
		    fi;
		fi;
	    fi;
	    
	    j=$(( $j + 1 ))
	done;
	i=$(( $i + 1 ))
    done;
    a=$(( $a + 1 ))
done;

fichier=$(echo "-e filename='"$7"' ")
gnuplot $fichier script_gnu/script_case_page.gnu


fi;
