clear;
close all;
load donnees;
figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

X_c = X;
X_c = double(X_c);
[n,p] = size(X_c);

% Calcul de l'individu moyen :
individu_moyen = mean(X_c);

% Centrage des donnees :
X_c = X_c - repmat(individu_moyen,n,1);

% Calcul de la matrice Sigma_2 (de taille n x n) :
Sigma_2 = (1/n) * (X_c * X_c');

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
[W,D] = eig(Sigma_2);

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[diagD, ind] = sort(diag(D), 'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
W_temp = ones(size(W));
W_temp(:,[1,2,3,4,5,6,7,8,9]) = W(:,ind);
W = W_temp;

% Elimination du dernier vecteur propre de Sigma_2 :
W = W(:,1:(n-1));

% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = X_c' * W;

% Normalisation des vecteurs propres de Sigma :
norme_eigenfaces = sqrt(sum(W .^ 2))
W  = W ./ (ones(p,1) * norme_eigenfaces);

% Affichage de l'individu moyen et des eigenfaces sous forme d'images :
 colormap gray;
 img = reshape(individu_moyen,nb_lignes,nb_colonnes);
 subplot(nb_individus,nb_postures,1);
 imagesc(img);
 axis image;
 axis off;
 title('Individu moyen','FontSize',15);
 for k = 1:n-1
	img = reshape(W(:,k),480,640);
	subplot(nb_individus,nb_postures,k+1);
	imagesc(img);
	axis image;
	axis off;
	title(['Eigenface ',num2str(k)],'FontSize',15);
 end

save exercice_1;
