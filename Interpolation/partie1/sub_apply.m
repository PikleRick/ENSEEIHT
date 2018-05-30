    function [Grille_res] = sub_apply(nbIter, degre, grille)

% Entrée : 
%   grille : abcisses d'une grille de points. 
% Sortie :
%   Grille où on a appliqué u=la subdivision fermée sur chacune des lignes 


n = size(grille,1);
m = size(grille,2);
Grille_res = zeros(n, ((2^nbIter)*m)+1); 

for i=1:n
    X_i = grille(i,:);
    [Grille_res_i,~] = subdivision_ferme(nbIter, degre, X_i, zeros(1,20)); 
    Grille_res(i,:) = Grille_res_i; 
end 
end 