clear;
close all;

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Filtrage frequentiel','Position',[0,0,L,H]);

% Lecture et affichage de l'image originale u :
u = double(imread('Barbara.png'));
[nb_lignes,nb_colonnes] = size(u);
subplot(2,3,4);
imagesc(u);
axis image off;
colormap gray;
title('Image originale','FontSize',20);

% Spectre de u :
s = fft2(u);
s = fftshift(s);		% Permet de positionner l'origine (n_x,n_y) = (0,0) au centre

% Affichage du logarithme du module du spectre de u :
subplot(2,3,1);
imagesc(log(abs(s)));
axis image off;
colormap gray;
title('Spectre','FontSize',20);

% Frequences en x et en y (axes = repere matriciel) :
[n_x,n_y] = meshgrid(1:nb_lignes,1:nb_colonnes);
n_x = n_x/nb_lignes-0.5;	% Frequences dans l'intervalle [-0.5,0.5]
n_y = n_y/nb_colonnes-0.5;

% Filtrage passe-bas :
eta = 0.05;
%n_c = ones(length(n_x),1) ./ (1 + (n_x.^2+n_y.^2)/eta);			% Frequence de coupure (faire varier ce parametre)
%passe_bas = n_x.^2+n_y.^2<n_c^2;
passe_bas = 1 ./ (1 + (n_x.^2+n_y.^2)/eta);
s_c = passe_bas.*s;

% Affichage du logarithme du module du spectre de c :
subplot(2,3,2);
imagesc(log(abs(s_c)));
axis image off;
colormap gray;
title('Basses frequences','FontSize',20);

%%
% Operateur gradient :
nb_pixels = nb_lignes*nb_colonnes;
e = ones(nb_pixels,1);
Dx = spdiags([-e e],[0 nb_lignes],nb_pixels,nb_pixels);
Dx(nb_pixels-nb_lignes+1:nb_pixels,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels,nb_pixels);
Dy(nb_lignes:nb_lignes:nb_pixels,:) = 0;

% Second membre b du systeme :
b = u(:);
c = u;

% % Matrice R de preconditionnement :
% W = spdiags(1 ./ sqrt(epsilon + (Dx*c(:)).^2 + (Dy*c(:)).^2),0,nb_pixels,nb_pixels);
% LapW = -Dx'*W*Dx - Dy'*W*Dy;
% Lap = -Dx'*Dx - Dy'*Dy;
% lambda = 10.5; % Poids de la regularisation
% A = speye(nb_pixels) - lambda*LapW;
% R = ichol(A,struct('droptol',1e-3));
epsilon = 0.01;
lambda = 50; % Poids de la regularisation
nb_iterations = 20;
for i = 1:nb_iterations
    
    % Matrice R de preconditionnement :
    W = spdiags(1 ./ sqrt(epsilon + (Dx*c(:)).^2 + (Dy*c(:)).^2),0,nb_pixels,nb_pixels);
    LapW = -Dx'*W*Dx - Dy'*W*Dy;

    A = speye(nb_pixels) - lambda*LapW;
    R = ichol(A,struct('droptol',1e-3));
    
    
    % Resolution du systeme A*x = b (gradient conjugue preconditionne) :

    %[x,flag] = pcg(A,b,1e-5,50,R',R,c(:));  
    x = A \ b;
    c = reshape(x,nb_lignes,nb_colonnes);


end
%%

% Affichage de c :
%c = real(ifft2(ifftshift(s_c)));
subplot(2,3,5);
imagesc(c);
axis image off;
colormap gray;
title('Cartoon','FontSize',20);

% Filtrage passe-haut :
s_t = (1-passe_bas).*s;

% Affichage du logarithme du module du spectre de t :
subplot(2,3,3);
imagesc(log(abs(s_t)));
axis image off;
colormap gray;
title('Hautes frequences','FontSize',20);

% Affichage de t :
%t = real(ifft2(ifftshift(s_t)));
subplot(2,3,6);
imagesc(u-c);
axis image off;
colormap gray;
title('Texture','FontSize',20);
