
#include "../inc/liste.h"

liste list_vide(){
  return NULL;
}

int est_list_vide(liste l){
  return (l==NULL);
}

liste insere_element_liste(liste l,element elem){
  liste l_a=(liste)alloc_mem(1,sizeof(struct_cellule));
  liste lt=l;
  l_a->objet=elem;
  l_a->suivant=NULL;
  if(l==NULL){
    return l_a;
  }
  while(lt->suivant!=NULL){
    lt=lt->suivant;
  }
  lt->suivant=l_a;
  return l;
}

element renvoie_sommet_liste(liste l){
  return l->objet;
}

liste supprimer_premier_liste(liste l){
  liste suivant;
  suivant=l->suivant;
  libere_mem(&l);
  return suivant;
}

int longueur_liste(liste l){
  if(est_list_vide(l)){
    return 0;
  }
  return 1 + longueur_liste(l->suivant);
}

void supprime_liste(liste l){
  if(!est_list_vide(l)){
    supprime_liste(l->suivant);
    libere(l);
  }
}

liste liste_sans_premier(liste l){
  return l->suivant;
}

liste concat_liste(liste l1,liste l2){
  liste lt;
  if(l1==NULL){
    return l2;
  }
  if(l2==NULL){
    return l1;
  }
  lt=l1;
  while(lt->suivant!=NULL){
    lt=lt->suivant;
  }
  lt->suivant=l2;
  return l1;
}

liste supprime_element(liste l,element e){
  liste lt;
  lt=l;
  if(l->objet==e){
    return supprimer_premier_liste(l);
  }
  while(lt->suivant!=NULL){
    if(lt->suivant->objet==e){
      lt->suivant=supprimer_premier_liste(lt->suivant);
      return l;
    }
    lt=lt->suivant;
  }
  return l;
}

int est_dans_liste(liste l ,element e){
  if (l==NULL){
    return 0;
  }
  if(l->objet==e){
    return 1;
  }
  return  est_dans_liste(l->suivant,e);
}
