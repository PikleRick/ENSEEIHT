clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Separation des composantes de C','Position',[0,0,0.67*L,0.67*H]);
figure('Name','Nuage de pixels dans le repere des composantes principales de C','Position',[0.67*L,0,0.33*L,0.45*H]);

% Lecture et affichage d'une image RVB :
I = imread('autumn.tif');
figure(1);				% Premiere fenetre d'affichage
subplot(2,2,1);				% La fenetre comporte 2 lignes et 2 colonnes
imagesc(I);
axis off;
axis equal;
title('Image RVB','FontSize',20);

% Decoupage de l'image en trois canaux et conversion en doubles :
R = double(I(:,:,1));
V = double(I(:,:,2));
B = double(I(:,:,3));

% matrice Sigma de variance/ covariance (de taille 3*3)
X = [R(:) V(:) B(:)];
n = length(X);
Xc = zeros(size(X));
Xc(:,1) = X(:,1) - ((sum(X(:,1))/n) * ones(n,1));
Xc(:,2) = X(:,2) - ((sum(X(:,2))/n) * ones(n,1));
Xc(:,3) = X(:,3) - ((sum(X(:,3))/n) * ones(n,1));

Sigma = (1/n) * Xc' * Xc;

% Coefficients de corrélation lineaire
R_rv = Sigma(1,2) / sqrt(Sigma(1,1) * Sigma(2,2));
R_rb = Sigma(1,3) / sqrt(Sigma(1,1) * Sigma(3,3));
R_vb = Sigma(2,3) / sqrt(Sigma(3,3) * Sigma(2,2));

% Proportions de contraste
Cr = (Sigma(1,1))/((Sigma(1,1)) + (Sigma(2,2)) + (Sigma(3,3)));
Cv = (Sigma(2,2))/((Sigma(1,1)) + (Sigma(2,2)) + (Sigma(3,3)));
Cb = (Sigma(3,3))/((Sigma(1,1)) + (Sigma(2,2)) + (Sigma(3,3)));

% ACP
[W,D] = eig(Sigma);
[diagD, ind] = sort(diag(D), 'descend');

W_temp = ones(size(W));
W_temp(:,1) = W(:,ind(1));
W_temp(:,2) = W(:,ind(2));
W_temp(:,3) = W(:,ind(3));
W = W_temp;

C_temp = Xc * W;
C = ones([size(R),3]);
C(:,:,1) = reshape(C_temp(:,1), size(R));
C(:,:,2) = reshape(C_temp(:,2), size(R));
C(:,:,3) = reshape(C_temp(:,3), size(R));

% Les composantes principales de C
C1 = C(:,:,1);
C2 = C(:,:,2);
C3 = C(:,:,3);

% recalcul du nouveau Sigma
% matrice Sigma de variance/ covariance (de taille 3*3)
X = [C1(:) C2(:) C3(:)];       % Les trois canaux sont vectorises et concatenes
n = length(X);
Xc = zeros(size(X));
Xc(:,1) = X(:,1) - ((sum(X(:,1))/n) * ones(n,1));
Xc(:,2) = X(:,2) - ((sum(X(:,2))/n) * ones(n,1));
Xc(:,3) = X(:,3) - ((sum(X(:,3))/n) * ones(n,1));

Sigma = (1/n) * Xc' * Xc;

% Coefficients de corrélation
R_rv = Sigma(1,2) / sqrt(Sigma(1,1) * Sigma(2,2))
R_rb = Sigma(1,3) / sqrt(Sigma(1,1) * Sigma(3,3))
R_vb = Sigma(2,3) / sqrt(Sigma(3,3) * Sigma(2,2))

% Proportions de contraste
Cr = (Sigma(1,1))/((Sigma(1,1)) + (Sigma(2,2)) + (Sigma(3,3)))
Cv = (Sigma(2,2))/((Sigma(1,1)) + (Sigma(2,2)) + (Sigma(3,3)))
Cb = (Sigma(3,3))/((Sigma(1,1)) + (Sigma(2,2)) + (Sigma(3,3)))
% fin calcul Sigma


% Affichage de la premiere composante :
colormap gray;				% Pour afficher les images en niveaux de gris
subplot(2,2,2);
imagesc(C1);
axis off;
axis equal;
title('Composante C1','FontSize',20);

% Affichage de la seconde composante :
subplot(2,2,3);
imagesc(C2);
axis off;
axis equal;
title('Composante C2','FontSize',20);

% Affichage de la troisieme composante :
subplot(2,2,4);
imagesc(C3);
axis off;
axis equal;
title('Composante C3','FontSize',20);

% Affichage du nuage de pixels dans le repere RVB :
figure(2);				% Deuxieme fenetre d'affichage
plot3(C1,C2,C3,'b.');
axis equal;
xlabel('C1');
ylabel('C2');
zlabel('C3');
rotate3d;

%   La premiere composante principale de C est celle comportant le plus de
% contraste
%   Cela est du au fait que l'on préalablement trié les valeurs propres de
%  Sigma par ordre décroissant
