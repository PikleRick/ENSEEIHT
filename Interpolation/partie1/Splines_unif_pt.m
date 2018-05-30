%  Surfaces splines fermées en produit tensoriel utilisant la subdivision
%  On utilise la topologie du tore 


% Importation de la topologie 

% Grille = grille(); 
Grille = tore();

X = Grille(:,:,1);
Y = Grille(:,:,2);
Z = Grille(:,:,3);

% On applique la subdivision fermée en produit tensoriel 

[X_res] = sub_apply(nbIter, degre, X); 
[Y_res] = sub_apply(nbIter, degre, Y); 
[Z_res] = sub_apply(nbIter, degre, Z); 
[X_res_tenso] = sub_apply(nbIter, degre, X_res'); 
[Y_res_tenso] = sub_apply(nbIter, degre, Y_res'); 
[Z_res_tenso] = sub_apply(nbIter, degre, Z_res'); 


% Affichage
figure('Name','Spline uniformes en produit tensoriel')
title(['nbIter = ',num2str(nbIter),' degre = ', num2str(degre)])
hold on 
view(10,40); 
surf(X',Y',Z');
alpha 0.3
% surf(X_res', Y_res', Z_res')
surf(X_res_tenso', Y_res_tenso', Z_res_tenso')
alpha 0.6
