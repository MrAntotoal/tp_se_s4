#!/usr/bin/env bash


mkdir obj_tex
cd obj_tex
pdflatex ../latex/Rapport.tex
mv Rapport.pdf ../Rapport.pdf
cd ..
evince -w Rapport.pdf
rm -r obj_tex
