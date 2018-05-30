%--------------------------------------------------------------------------
% ENSEEIHT - 2IMA - Traitement des donnees Audio-Visuelles
% TP7 - Restauration d'images
% exercice_2.m : Inpainting
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
u0 = double(imread('randonneur.jpg'));
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
u_max = max(u0(:));

nb_pixels = nb_lignes*nb_colonnes;

% Ajout d'un bruit gaussien :
sigmAbruit = 0.00;
u0 = u0 + sigmAbruit*u_max*randn(nb_lignes,nb_colonnes);

% Lecture du masque de l'image
masque = double(imread('randonneur_masque.jpg')) ./255;
W0 = ones(size(masque)) - masque;
W0 = spdiags(W0(:), 0, nb_pixels, nb_pixels);


% Affichage de l'image bruitee :
subplot(1,2,1)
    imagesc(max(0,min(1,u0/u_max)),[0 1])
    colormap gray
    axis image off
    title('Image bruitee','FontSize',20)

e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:nb_pixels,:) = 0;

% Second membre b du systeme :
br = u0(:,:,1);
br = W0*br(:);
bv = u0(:,:,2);
bv = W0*bv(:);
bb = u0(:,:,3);
bb = W0*bb(:);

lambda = 1;
eps = 0.01;

Lap = -Dx'*Dx - Dy'*Dy;
A = speye(nb_pixels) - lambda*Lap;
R = ichol(A,struct('droptol',1e-3));

u = u0;
nb_iterations = 15;

for i = 1 : nb_iterations
    ur = u(:,:,1);
    uv = u(:,:,2);
    ub = u(:,:,3);
    
    Wr = 1./sqrt((Dx*ur(:)).^2 + (Dy*ur(:)).^2 + eps);
    Wr = spdiags(Wr, 0, nb_pixels, nb_pixels);
    Ar = W0 - lambda * ( (-Dx'*Wr*Dx - Dy'*Wr*Dy) );
    u_prec_R = ur;
    [x_R,flag] = pcg(Ar,br,1e-5,50,R',R,ur(:));
    ur = reshape(x_R,nb_lignes,nb_colonnes);
    
    Wv = 1./sqrt((Dx*uv(:)).^2 + (Dy*uv(:)).^2 + eps);
    Wv = spdiags(Wv, 0, nb_pixels, nb_pixels);
    Av = W0 - lambda * ( (-Dx'*Wv*Dx - Dy'*Wv*Dy) );
    u_prec_V = uv;
    [x_V,flag] = pcg(Av,bv,1e-5,50,R',R,uv(:));
    uv = reshape(x_V,nb_lignes,nb_colonnes);
    
    Wb = 1./sqrt((Dx*ub(:)).^2 + (Dy*ub(:)).^2 + eps);
    Wb = spdiags(Wb, 0, nb_pixels, nb_pixels);
    Ab = W0 - lambda * ( (-Dx'*Wb*Dx - Dy'*Wb*Dy) );
    u_prec_B = ub;
    [x_B,flag] = pcg(Ab,bb,1e-5,50,R',R,ub(:));
    ub = reshape(x_B,nb_lignes,nb_colonnes);

    u(:,:,1) = ur;
    u(:,:,2) = uv;
    u(:,:,3) = ub;
end


% Affichage de l'image restauree :
subplot(1,2,2)
    imagesc(max(0,min(1,u/u_max)),[0 1])
    colormap gray
    axis image off
    title('Image restauree','FontSize',20)