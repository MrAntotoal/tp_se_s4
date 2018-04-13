#include "allocation_memoire.h"

typedef int element;

typedef struct cellule{
  element objet;
  struct cellule * suivant;
}struct_cellule;

typedef struct_cellule * liste;

liste list_vide();
int est_list_vide(liste l);
liste insere_element_liste(liste l,element elem);
element renvoie_sommet_liste(liste l);
liste supprimer_premier_liste(liste l);
int longueur_liste(liste l);
void supprime_liste(liste l);
liste liste_sans_premier(liste l);
liste concat_liste(liste l1,liste l2);
liste supprime_element(liste l,element e);
int est_dans_liste(liste l ,element e);
