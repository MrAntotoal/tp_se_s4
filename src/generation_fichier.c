#include "../inc/allocation_memoire.h"
#include <math.h>
#include <time.h>

void erreur(char *s){
  fprintf(stderr,"erreur argument\n%s <nbr_acces> <nbr_page> <longueur_moyenne> <fichier_enregistrement> <seed>\n",s);
}

int moyenne(int l,int nbr){
  int n=0,i;
  for(i=0;i<nbr;i++){
    n+=rand()%(l*2);
  }
  return n/(nbr+1);
}

int main(int argc,char *argv[]){
  int nbr_acces,nbr_page,longueur_moyenne,i,ancien,l,seed;
  char *chemin;
  FILE *f1;
  time_t temps;
  temps=time(NULL);
  if(argc<5){
    erreur(argv[0]);
    exit(-1);
  }
  nbr_acces=atoi(argv[1]);
  nbr_page=atoi(argv[2]);
  longueur_moyenne=atoi(argv[3]);
  chemin=argv[4];
  seed=atoi(argv[5]);
  temps+=seed;
  srand(temps);
  //fprintf(stderr,"%ld seed",temps);
  
  if((f1=fopen(chemin,"w"))==NULL){
    fprintf(stderr,"erreur ouveture fichier %s",chemin);
    exit(-1);
  }
  
  fprintf(f1,"%d\n",nbr_acces);
  fprintf(f1,"%d\n",nbr_page);
  
  if(longueur_moyenne!=-1){
    
    ancien=rand()%(nbr_page);
    l=moyenne(longueur_moyenne,20);
    for(i=0;i<nbr_acces;i++){
      if(l<0){
	l=moyenne(longueur_moyenne,20);
	ancien=rand()%(nbr_page);
      }
      fprintf(f1,"%d\n",ancien);
      l--;
    }
  }
  else{
    for(i=0;i<nbr_acces;i++){
      fprintf(f1,"%d\n",rand()%(nbr_page));
    }
  }
  fclose(f1);
  exit(0);
}
