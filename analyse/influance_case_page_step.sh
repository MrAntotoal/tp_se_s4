#!/usr/bin/env bash

if (( $# != 8 ))
then
    echo "erreur arg <min case> <max case> < min page> <max page> <puissance nb acces> <moyenne> <fichier de sortie> <step>
le fichier sera formater pour gnuplot"
else
echo "# min case : "$1"  max case : "$2"  min page : "$3"  max page : "$4" puissance acces : "$5" moyenne : "$6 "step : "$8>> $7

afficacite=0
min_case=$1
max_case=$2
min_page=$3
max_page=$4
moyenne=$6
step=$8
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

i=$min_case
j=$min_page

while(( $i <= $max_case ))
do
    echo "case actu "$i
    j=$min_page
    while(( $j <= $max_page ))
    do
	liste1=("" "")
	liste2=("" "")
	liste3=("" "")
	liste4=("" "")
	m=0
	while(( $m <= $moyenne))
	do
	    ./../bin/generation_fichier  $(( 2 ** $5))   $j -1 "entrer" $seed
	    r=$(./../bin/test_algo 1  $i  0 "entrer")
	    #echo $r "case"$i "page"$j
	    liste1=("$r" "${liste1[@]}")
	    r=$(./../bin/test_algo 2  $i  0 "entrer")
	    liste2=("$r" "${liste2[@]}")
	    r=$(./../bin/test_algo 3  $i  0 "entrer")
	    liste3=("$r" "${liste3[@]}")
	    r=$(./../bin/test_algo 4  $i  0 "entrer")
	    liste4=("$r" "${liste4[@]}")
	    seed=$(( $seed + 1 ))
	    rm entrer
	    m=$(( $m + 1 ))
	   
	done;
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
	j=$(( $j + $step ))
	
    done;
    i=$(( $i + $step ))
done;



i=$min_case
j=$min_case
a=1
index=0
while(( $a <= 4))
do
    echo "

#algo"$a >>$7
    index=0
    i=$min_case
    while (( $i <= $max_case ))
    do
	j=$min_case
	while (( $j <= $max_page))
	do
	    if (( $a == 1 ))
	    then
		echo $i   $j  ${liste_m1[$index]} >> $7
	    else
		if (( $a == 2 ))
		then
		    echo $i   $j  ${liste_m2[$index]} >> $7
		else
		    if (( $a == 3 ))
		    then
			echo $i  $j  ${liste_m3[$index]} >> $7
		    else
			echo  $i   $j  ${liste_m4[$index]} >> $7
		    fi;
		fi;
	    fi;
	    index=$(( $index + 1))
	    j=$(( $j + $step ))
	done;
	i=$(( $i + $step ))
    done;
    a=$(( $a + 1 ))
done;

fichier=$(echo "-e filename='"$7"' ")
gnuplot $fichier script_gnu/script_case_page.gnu


fi;
