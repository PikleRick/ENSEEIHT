% l'indice correspondant au triplet d'indices (i,j,k)
% en effet, x est au départ une matrice tridimensionnelle, qu'il faudra transformer 
% en vecteur colonne pour permettre son calcul par linprog et/ou intlinprog.
% Dans notre représentation vectorielle de la matrice tridimensionnelle x,
% on fait en sorte d'incrémenter i puis j, et finalement k

function indice = indiceEq(i,j,k,p,c) %l'indice équivalent

indice = 1 + (i - 1) + (j - 1) * p + (k - 1) * p * c;

end