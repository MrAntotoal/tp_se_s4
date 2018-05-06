#include "../inc/liste.h"
#include <string.h>

void help(char nom[]){
  fprintf(stderr,"%s <num_algo> <nbr_case> <option> <fichier>\nNum Algo: \n 1-> fifo \n 2->lru \n 3->horloge \n 4->optimal \npar defaut num algo est a 1 \n \nOption : \n 0->pas d'affiche debug\n 1->affichage debug\n par defaut 0\n",nom);
}

void erreur(){
  fprintf(stderr,"erreur synthaxe -h ou -help pour la synthaxe \n");
}


void affiche_valide(int valide[],int nbr_page){
  int i;
  for(i=0;i<nbr_page;i++){
    if(valide[i]!=-1){
      printf(" %d",i);
    }
  }
  printf("\n");
}

int fifo(int *acces,int option,int nbr_case,int nbr_page,int nbr_acces){
  int valide[nbr_page],temp,defaut=0,i;
  liste ordre;

  for (i=0;i<nbr_page;i++){
    valide[i]=-1;
  }
   
  ordre=list_vide();
  for(temp=0;temp<nbr_acces;temp++){
    if(valide[acces[temp]]!=1){
      defaut++;
      if(longueur_liste(ordre)<nbr_case){
	valide[acces[temp]]=1;
	ordre=insere_element_liste(ordre,acces[temp]);
      }
      else{
	valide[renvoie_sommet_liste(ordre)]=-1;
	ordre=supprimer_premier_liste(ordre);
	valide[acces[temp]]=1;
	ordre=insere_element_liste(ordre,acces[temp]);
      }
    }
    if(option==1){
      affiche_valide(valide,nbr_page);
    }
  }
  supprime_liste(ordre);
  return defaut;
}

/*ici pas sur
a cause de la gestion de si il ya encore de la memoire dispo*/
int lru(int *acces,int option,int nbr_case,int nbr_page,int nbr_acces){
  int temp,defaut=0,dernier_acces[nbr_page],i,min,a,dernier;

  for (i=0;i<nbr_page;i++){
    dernier_acces[i]=-1;
  }

  for (temp=0;temp<nbr_acces;temp++){
    if(dernier_acces[acces[temp]]==-1){
      defaut++;
      if(nbr_case!=0){
	dernier_acces[acces[temp]]=temp;
	nbr_case--;
      }
      else{
	min=temp;
	for(i=0;i<nbr_page;i++){
	  a=dernier_acces[i];
	  if(a!=-1){
	    if(a<min){
	      min=a;
	      dernier=i;
	    }
	  }
	}
	dernier_acces[dernier]=-1;
	dernier_acces[acces[temp]]=temp;
      }
      
    }
    else{
      dernier_acces[acces[temp]]=temp;
    }
    if(option==1){
      affiche_valide(dernier_acces,nbr_page);
    }
  }
  return defaut;
}



int horloge (int *acces,int option,int nbr_case,int nbr_page,int nbr_acces){
  int temp,defaut=0,valide[nbr_page],i,page_a_suppr;
  liste l;
  l=list_vide();

  for (i=0;i<nbr_page;i++){
      valide[i]=-1;
  }
  
  for (temp=0;temp<nbr_acces;temp++){
    if(valide[acces[temp]]==-1){
      defaut++;
      if(longueur_liste(l)<nbr_case){
	valide[acces[temp]]=1;
	l=insere_element_liste(l,acces[temp]);
      }
      else{
	page_a_suppr=renvoie_sommet_liste(l);
	while(valide[page_a_suppr]==1){
	  l=supprimer_premier_liste(l);
	  l=insere_element_liste(l,page_a_suppr);
	  valide[page_a_suppr]=0;
	  page_a_suppr=renvoie_sommet_liste(l);
	}

	valide[page_a_suppr]=-1;
	l=supprimer_premier_liste(l);
	valide[acces[temp]]=1;
	l=insere_element_liste(l,acces[temp]);
      }
    }
    else{
      valide[acces[temp]]=1;
    }
    if(option==1){
      affiche_valide(valide,nbr_page);
    }
  }
  supprime_liste(l);
  return defaut;
}


int est_dans_les_prochain_acces(int *acces,int temp,int nbr_acces,int val){
  int i;
  for(i=temp;i<nbr_acces;i++){
    if(acces[i]==val){
      return 1;
    }
  }
  return 0;
}

int optimal(int *acces,int option,int nbr_case,int nbr_page,int nbr_acces){
  int temp,defaut=0,valide[nbr_page],i,page_a_suppr,j,tab[nbr_page],cmp,case_tot;
  case_tot=nbr_case;
  for (i=0;i<nbr_page;i++){
    valide[i]=-1;
      tab[i]=0;
  }
  for (temp=0;temp<nbr_acces;temp++){
    if(valide[acces[temp]]!=1){
      defaut++;

      if(nbr_case!=0){
	valide[acces[temp]]=1;
	nbr_case--;
      }
      else{
	if(nbr_acces-temp-1<case_tot){
	  i=0;
	  while(!(est_dans_les_prochain_acces(acces,temp+1,nbr_acces,i)==0 && valide[i]==1)){
	    //fprintf(stderr,"%d ",i);
	    i++;
	  }
	  page_a_suppr=i;
	}
	else{
	  page_a_suppr=-1;
	  
	  
	  for(i=0;i<nbr_page;i++){
	    if(valide[i]==1){
	      if(est_dans_les_prochain_acces(acces,temp+1,nbr_acces,i)==0){
		page_a_suppr=i;
		break;
	      }
	    }
	  }
	  if(page_a_suppr==-1){
	    for(i=0;i<nbr_page;i++){
	      tab[i]=0;
	    }
	    cmp=0;
	    for(j=temp+1;j<nbr_acces;j++){
	      if(cmp!=case_tot){
		if(valide[acces[j]]==1 && tab[acces[j]]==0){
		  page_a_suppr=acces[j];
		  tab[acces[j]]=1;
		  cmp++;
		}
	      }
	      else{
		break;
	      }
	    }
	  }
	}
	valide[acces[temp]]=1;
	valide[page_a_suppr]=-1;
      }
    }
    if(option==1){
      affiche_valide(valide,nbr_page);
    }
  }
  return defaut;
}


int main(int argc,char *argv[]){
  int *acces,i,num_algo,nbr_case,nbr_page,option,d,nbr_acces;
  FILE *f1;
  for(i=1;i<argc;i++){
    if(strcmp(argv[i],"-h")==0 || strcmp(argv[i],"-help")==0){
      help(argv[0]);
      exit(-1);
    }
  }
  
  if(argc<5){
    erreur();
    exit(-1);
  }
  num_algo=atoi(argv[1]);
  nbr_case=atoi(argv[2]);
  option=atoi(argv[3]);
  if((f1=fopen(argv[4],"r"))==NULL){
    fprintf(stderr,"erreur ouverture fichier %s\n",argv[4]);
    exit(-1);
  }
  if(fscanf(f1,"%d",&nbr_acces)!=1 || fscanf(f1,"%d",&nbr_page)!=1){
    fprintf(stderr,"erreur formatage du fichier %s \n",argv[4]);
    exit(-1);
  }
  acces=alloc_mem(sizeof(int),nbr_acces);
  i=0;
  for(i=0;i<nbr_acces;i++){
    if(fscanf(f1,"%d",&acces[i])!=1){
      fprintf(stderr,"erreur formatage du fichier %s \n",argv[4]);
      exit(-1);
    }
  }
  
  if(num_algo==4){
    d=optimal(acces,option,nbr_case,nbr_page,nbr_acces);
    fprintf(stdout,"%f\n",(float)d/(float)nbr_acces);
  }
  else{
    if(num_algo==3){
      d=horloge(acces,option,nbr_case,nbr_page,nbr_acces);
      fprintf(stdout,"%f\n",(float)d/(float)nbr_acces);
    }
    else{
      if(num_algo==2){
	d=lru(acces,option,nbr_case,nbr_page,nbr_acces);
	fprintf(stdout,"%f\n",(float)d/(float)nbr_acces);
      }
      else{
	d=fifo(acces,option,nbr_case,nbr_page,nbr_acces);
	fprintf(stdout,"%f\n",(float)d/(float)nbr_acces);
      }
    }
  }
  libere(acces);
  exit(0);

}
