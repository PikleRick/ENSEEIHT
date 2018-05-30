% Calcul de la distribution limite de Xn
% fonction de P et PI0 et d'un epsilon
function PIfinal = Dist_lim(PI0, P, eps)

% si jamais ça marche pas et que le prob vient de cette
% 	fonction, ajouter la seconde condition

I = eye(length(P));

PI = PI0;
PI_transpose = PI';

nbIterMax = 100;
nbIter = 0;

while (norm(PI_transpose * (I - P)) >= eps) && (nbIter < nbIterMax)
	PI_transpose = PI_transpose * P;
    nbIter = nbIter + 1;
end

PI = PI_transpose';
PIfinal = PI;

