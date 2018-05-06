cc=gcc
option= -Wall

all: test_algo generation courbe moyenne

test_algo: allocation_memoire.o liste.o src/algo_remplacement.c bin obj
	$(cc) $(option)  obj/allocation_memoire.o obj/liste.o src/algo_remplacement.c -o bin/test_algo
	rm inc/*.gch

generation: allocation_memoire.o src/generation_fichier.c bin obj
	$(cc) $(option)  obj/allocation_memoire.o src/generation_fichier.c -o bin/generation_fichier

courbe: obj/allocation_memoire.o src/c3_to_c2.c
	$(cc) $(option)  obj/allocation_memoire.o src/c3_to_c2.c -o bin/c3_to_c2 -lm

moyenne: src/moyenne.c
	$(cc) $(option) src/moyenne.c -o bin/moyenne

liste.o: inc/liste.h src/liste.c obj
	$(cc) $(option) inc/liste.h src/liste.c -c 
	mv liste.o obj/liste.o

allocation_memoire.o: src/allocation_memoire.c inc/allocation_memoire.h obj
	$(cc) $(option) src/allocation_memoire.c inc/allocation_memoire.h -c
	mv allocation_memoire.o obj/allocation_memoire.o

obj:
	mkdir obj 

bin:
	mkdir bin
clean:
	rm -rf obj
	rm -rf bin

