#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(int argc ,char * argv[]){
  float min ,max,somme,a;
  int i;
  min=LONG_MAX;
  max=LONG_MIN;
  somme=0.0;
  for (i=1;i<argc;i++){
    a=atof(argv[i]);
    if(a>max){
      max=a;
    }
    if(a<min){
      min=a;
    }
    somme+=a;
  }
  /*on a un tab si on veux calculer l ecart type*/
  somme-=(min+max);
  fprintf(stdout,"%f",somme/((float)argc-3.0));
  exit(0);
}
