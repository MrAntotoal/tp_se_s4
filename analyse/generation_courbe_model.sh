#!/usr/bin/env bash

if(( $# != 6))
then
    echo "<puissance min case> <puissance max case> <puissance min page> <puissance max page> < puissance nb acces> <fichier sortie> "
else
    echo "#puissance min case "$1" puissance max case "$2" puissance min page "$3" puissance max page "$4" puissance nb acces"$5 >>$6

    echo "

#modele" >>$6
    i=$1
    j=$3
    a=$5
    r_acces=$(( 2 ** $a ))
    while(( $i <= $2 ))
    do
	j=$3
	r_case=$(( 2 ** $i ))
	while(( $j <= $4 ))
	do
	    r_page=$(( 2 ** $j ))
	    if(( $i >= $j ))
	    then
		echo $r_case $r_page $(echo $r_page / $r_acces |bc -l) >>$6
	    else
		n=$(( $r_page - $r_case ))
		echo $r_case $r_page $(echo $n / $r_page |bc -l) >>$6
	    fi;
	    j=$(( $j + 1 ))
	done;

	i=$(( $i + 1 ))
    done;
    arg=$(echo "-e filename='"$6"'")
    gnuplot $arg script_gnu/script_case_page_model.gnu
fi;
