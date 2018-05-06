#!/usr/bin/env bash

if (( $# != 2 ))
then
    echo "<nom fichier> <type courbe>

1-> 3d case page
2-> 3d case page model
3-> 2d case fixe (*_c*)
4-> 2d page fixe (*_p*)
5-> 2d nb acces"
else
    arg=$(echo "-e filename='"$1"'")
    if(( $2 == 1))
    then
	gnuplot $arg script_gnu/script_case_page.gnu
    else
	if(( $2 == 2 ))
	then
	    gnuplot $arg script_gnu/script_case_page_model.gnu
	else
	    if(( $2 == 3 ))
	    then
		gnuplot $arg script_gnu/script_courbe_case_2d_aff.gnu
	    else
		if (( $2 == 4 ))
		then
		    gnuplot $arg script_gnu/script_courbe_page_2d_aff.gnu
		else
		    if(( $2 == 5 ))
		    then
			gnuplot $arg script_gnu/script_nb_acces_aff.gnu
		    else
			echo "erreur arg type courbe"
		    fi;
		    
		fi;
		
	    fi;
	    
	fi;
    fi;
fi;

