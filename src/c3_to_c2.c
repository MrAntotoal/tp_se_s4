
#include "../inc/allocation_memoire.h"
#include<math.h>
#include <string.h>


int ouverture_fichier(FILE ** f1,char* chemin,char *type){
  if((*f1=fopen(chemin,type))==NULL){
    fprintf(stderr,"erreur ouverture fichier %s",chemin);
    exit(-1);
  }
  return 0;
}

int main(int argc,char * argv[]){
  FILE *f1;
  FILE *f2;
  int puissance_case_min,puissance_case_max,nb_page,i,num_algo=1,j,n,mod,puissance_page_min,puissance_page_max;
  double taux;
  char *nom_fichier,fichier_actu[200],temp[100],algo[7];
  if(argc<1){
    //usage(argv[0]);
    exit(-1);
  }
  nom_fichier=argv[1];
  ouverture_fichier(&f1,nom_fichier,"r");
  fscanf(f1,"%s %s %s %s %d",temp,temp,temp,temp,&puissance_case_min);
  fscanf(f1,"%s %s %s %s %d",temp,temp,temp,temp,&puissance_case_max);
  fscanf(f1,"%s %s %s %s %d",temp,temp,temp,temp,&puissance_page_min);
  fscanf(f1,"%s %s %s %s %d",temp,temp,temp,temp,&puissance_page_max);
  fclose(f1);
  mod=0;
  for(i=puissance_case_min;i<=puissance_case_max;i++){
    ouverture_fichier(&f1,nom_fichier,"r");
    sprintf(fichier_actu,"%s_c_%d",nom_fichier,i);
    ouverture_fichier(&f2,fichier_actu,"w+");
    n=(int)pow(2.0,(double)i);
    num_algo=1;
    sprintf(algo,"#algo%d",num_algo);
    j=0;
    while(fscanf(f1,"%s",temp)==1){
      mod++;
      if(strcmp(algo,temp)==0){
	fprintf(f2,"\n\n\n%s",algo);
	num_algo++;
	sprintf(algo,"#algo%d",num_algo);
	j=1;
	mod=-1;
      }
      if(atoi(temp)==n && j==1 && mod%3==0){
	if(fscanf(f1,"%d %lf",&nb_page,&taux)==2){
	  fprintf(f2,"\n%d %d %lf",n,nb_page,taux);
	}
	mod=-1;
      }
    }
    fclose(f1);
    fclose(f2);
  }

    
    for(i=puissance_page_min;i<=puissance_page_max;i++){
    ouverture_fichier(&f1,nom_fichier,"r");
    sprintf(fichier_actu,"%s_p_%d",nom_fichier,i);
    ouverture_fichier(&f2,fichier_actu,"w+");
    n=(int)pow(2.0,(double)i);
    num_algo=1;
    sprintf(algo,"#algo%d",num_algo);
    j=0;
    while(fscanf(f1,"%s",temp)==1){
      mod++;
      if(strcmp(algo,temp)==0){
	fprintf(f2,"\n\n\n%s",algo);
	num_algo++;
	sprintf(algo,"#algo%d",num_algo);
	j=1;
	mod=-1;
      }
      if( j==1 && mod%3==0){
	if(fscanf(f1,"%d %lf",&nb_page,&taux)==2 && nb_page==n){
	  fprintf(f2,"\n%d %d %lf",atoi(temp),nb_page,taux);
	}
	mod=-1;
      }
    }
    fclose(f1);
    fclose(f2);
  }
  exit(0);
  
  
}
