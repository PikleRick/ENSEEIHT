%--------------------------------------------------------------------------
% ENSEEIHT - 2IMA - Traitement des donnees Audio-Visuelles
% TP7 - Restauration d'images
% exercice_1_bis.m
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
u0 = double(imread('lena.bmp'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
u_max = max(u0(:));

% Ajout d'un bruit gaussien :
sigma_bruit = 0.05;
u0 = u0 + sigma_bruit*u_max*randn(nb_lignes,nb_colonnes,3);
u0R = u0(:,:,1);
u0V = u0(:,:,2);
u0B = u0(:,:,3);

% Affichage de l'image bruitee :
subplot(1,2,1)
	imagesc(max(0,min(1,u0/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)

nb_iterations = 20;
epsilon = 0.01;

% Operateur gradient :
nb_pixels = nb_lignes*nb_colonnes;
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:nb_pixels,:) = 0;

% Second membre b du systeme :
bR = u0R(:);
bV = u0V(:);
bB = u0B(:);
u = u0;
uR = u0R;
uV = u0V;
uB = u0B;

% % Matrice R de preconditionnement :
% W = spdiags(1 ./ sqrt(epsilon + (Dx*u(:)).^2 + (Dy*u(:)).^2),0,nb_pixels,nb_pixels);
% LapW = -Dx'*W*Dx - Dy'*W*Dy;
% Lap = -Dx'*Dx - Dy'*Dy;
% lambda = 10.5; % Poids de la regularisation
% A = speye(nb_pixels) - lambda*LapW;
% R = ichol(A,struct('droptol',1e-3));

for i = 1:nb_iterations
    
    % Matrice R de preconditionnement :
    Wr = spdiags(1 ./ sqrt(epsilon + (Dx*uR(:)).^2 + (Dy*uR(:)).^2),0,nb_pixels,nb_pixels);
    Wv = spdiags(1 ./ sqrt(epsilon + (Dx*uV(:)).^2 + (Dy*uV(:)).^2),0,nb_pixels,nb_pixels);
    Wb = spdiags(1 ./ sqrt(epsilon + (Dx*uB(:)).^2 + (Dy*uB(:)).^2),0,nb_pixels,nb_pixels);

    LapWr = -Dx'*Wr*Dx - Dy'*Wr*Dy;
    LapWv = -Dx'*Wv*Dx - Dy'*Wv*Dy;
    LapWb = -Dx'*Wb*Dx - Dy'*Wb*Dy;

    lambda = 8.5; % Poids de la regularisation
    Ar = speye(nb_pixels) - lambda*LapWr;
    Rr = ichol(Ar,struct('droptol',1e-3));
    Av = speye(nb_pixels) - lambda*LapWv;
    Rv = ichol(Av,struct('droptol',1e-3));
    Ab = speye(nb_pixels) - lambda*LapWb;
    Rb = ichol(Ab,struct('droptol',1e-3));
    
    
    % Resolution du systeme A*x = b (gradient conjugue preconditionne) :
    [xr,flag] = pcg(Ar,bR,1e-5,50,Rr',Rr,uR(:));  
    uR = reshape(xr,nb_lignes,nb_colonnes);
    
    [xv,flag] = pcg(Av,bV,1e-5,50,Rv',Rv,uV(:));  
    uV = reshape(xv,nb_lignes,nb_colonnes);
    
    [xb,flag] = pcg(Ab,bB,1e-5,50,Rb',Rb,uB(:));  
    uB = reshape(xb,nb_lignes,nb_colonnes);


end

% Affichage de l'image restauree :
u(:,:,1) = uR;
u(:,:,2) = uV;
u(:,:,3) = uB;
subplot(1,2,2)
	imagesc(max(0,min(1,u/u_max)),[0 1])
	colormap gray
	axis image off
	title('Image restauree','FontSize',20)