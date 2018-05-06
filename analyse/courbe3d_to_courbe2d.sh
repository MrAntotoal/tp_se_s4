#!/usr/bin/env bash


if(($#!=3))
then
    echo 'erreur argument <fichier courbe 3d>  <dossier extraction> <pre visualisation>

pre visualisation 0 -> non 1-> oui';
else
mkdir $2

./../bin/c3_to_c2 $1

mv $1_* $2/
cd $2
nb=$(ls |grep $1_c_|wc -l)
nb=$(( $nb  ))
ls |grep $1_c_>tmp
for ((i=1;i<=$nb;i++ ))
do
    nom=""
    nom_courbe=""
    nom=$(cat tmp |head -n $i|tail -n 1)
    nom_courbe=$(echo $nom".pdf")
    arg=$(echo "filename='"$nom"'" "-e courbe_name='"$nom_courbe"'")
    gnuplot -e $arg ../script_gnu/script_courbe_case_2d.gnu
    if (( $3  == 1 ))
    then
	evince -w $nom_courbe
    fi;
done
rm tmp
nb=$(ls |grep $1_p_|wc -l)
nb=$(( $nb  ))
ls |grep $1_p_>tmp
for ((i=1;i<=$nb;i++ ))
do
    nom=""
    nom_courbe=""
    nom=$(cat tmp |head -n $i|tail -n 1)
    nom_courbe=$(echo $nom".pdf")
    arg=$(echo "filename='"$nom"'" "-e courbe_name='"$nom_courbe"'")
    gnuplot -e $arg ../script_gnu/script_courbe_page_2d.gnu
    if (( $3  == 1 ))
    then
	evince -w $nom_courbe
    fi;
    
    
done
rm tmp
fi;
