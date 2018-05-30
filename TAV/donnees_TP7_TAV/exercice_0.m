%--------------------------------------------------------------------------
% ENSEEIHT - 2IMA - Traitement des donnees Audio-Visuelles
% TP7 - Restauration d'images
% exercice_0.m : Debruitage avec modele de Tikhonov (niveaux de gris)
%--------------------------------------------------------------------------

clear
close all
clc

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage avec le modele de Tikhonov','Position',[0.06*L,0.1*H,0.9*L,0.7*H])

% Lecture de l'image :
u0 = double(imread('cameraman.tif'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
u_max = max(u0(:));

% Ajout d'un bruit gaussien :
sigma_bruit = 0.05;
u0 = u0 + sigma_bruit*u_max*randn(nb_lignes,nb_colonnes);

% Affichage de l'image bruitee :
subplot(1,2,1)
	imagesc(max(0,min(1,u0/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)

% Operateur gradient :
nb_pixels = nb_lignes*nb_colonnes;
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:nb_pixels,:) = 0;

% Second membre b du systeme :
b = u0(:);

% Matrice R de preconditionnement :
Lap = -Dx'*Dx - Dy'*Dy;
lambda = 1.5; % Poids de la regularisation
A = speye(nb_pixels) - lambda*Lap;
R = ichol(A,struct('droptol',1e-3));

% Resolution du systeme A*x = b (gradient conjugue preconditionne) :
u = u0;
[x,flag] = pcg(A,b,1e-5,50,R',R,u(:));
u = reshape(x,nb_lignes,nb_colonnes);

% Affichage de l'image restauree :
subplot(1,2,2)
	imagesc(max(0,min(1,u/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image restauree','FontSize',20)
