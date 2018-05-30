% Estimation de l?axe médian
clear all; 
load mask; 

% Estimation de la formule
% Les masques fournis sont inversés
im_zero = zeros(size(im_mask(:,:,1)));
im_mask_1 = (im_mask(:,:,1) == im_zero);
[nb_lignes,nb_colonnes,nb_canaux] = size(im_mask_1);

% Calcul d'un point initial sur la frontière util pour
% l'appel à bwtraceboundary 
k = ceil(nb_lignes/2);  
point_depart = zeros(2,1); 
for j=20:size(im_mask_1,2)
    if im_mask_1(k,j)== 1
        point_depart = [k j]; 
        break
    end 
end 

contour = bwtraceboundary(im_mask_1,point_depart,'NW'); 

% plot(contour(:,2), contour(:,1), 'g', 'LineWidth', 2); 

% Estimation des points du squelette
[vx_init, vy_init] = voronoi(contour(1:10:end,2), contour(1:10:end,1));

% Filtrage des points pour ne garder que ceux intérieurs à la forme
[vx,vy] = clean(im_mask_1, vx_init, vy_init,nb_lignes,nb_colonnes );

figure('Name', 'l''axe médian interne');
imshow(im_mask_1)
hold on
plot(vx, vy, 'r')
plot(contour(:,2), contour(:,1), 'g');
hold off;

