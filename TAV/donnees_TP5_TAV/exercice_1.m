clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

couleurs_classes = [0 0.1250 1.0 ; 0.1750 1.0 0.2250 ; 1.0 1.0 0 ; 1.0 0.3750 0 ; 0.85 0 0 ; 0.5 0 0.3 ; 0.5 0.5 0.1];

% Parametres de la methode de segmentation :
T_0 = 1.0;
q_max = 100;
alpha = 0.99;
beta = 1.0;
temps_affichage = 0.05;

% Lecture et affichage de l'image a segmenter :
I = imread('Images/image.bmp');
[nb_lignes,nb_colonnes] = size(I);
I = double(I);
figure('Name','Image a segmenter','Position',[0,0,0.5*L,0.5*L]);
imagesc(I);
axis equal;
axis off;
colormap gray;

% Parametres des N classes :
N = 6;
moyennes = [36.0 72.0 108.0 144.0 180.0 216.0];		% Moyennes des N classes
variances = 20.0^2*ones(1,N);				% Les variances sont toutes egales a 20^2

% Calcul des energies correspondant a la vraisemblance (attache aux donnees) :
AD = attache_donnees(I,moyennes,variances);

% Initialisation des classes (par le maximum de vraisemblance) et initialisation de l'energie :
couleurs_pixels = zeros(nb_lignes,nb_colonnes,3);
[U,k] = min(AD,[],3);			% Pour comprendre cette syntaxe, tapez "doc min"
for i = 1:nb_lignes
	for j = 1:nb_colonnes
		U(i,j) = U(i,j)+a_priori(i,j,k,k(i,j),beta);
		couleurs_pixels(i,j,:) = couleurs_classes(k(i,j),:);
	end
end
figure('Name',['Segmentation par classification'],'Position',[0.5*L,0,0.5*L,0.5*L]);
imagesc(couleurs_pixels);
axis equal;
axis off;
title(['Maximum de vraisemblance'],'FontSize',20);
fprintf('Tapez un caractere pour lancer le recuit simule\n');
pause;

% Boucle du recuit simule :
T = T_0;
for q = 1:q_max
	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			k_cour = k(i,j);
			U_cour = U(i,j);
			k_nouv = ceil(rand*N);
			while k_nouv==k_cour
				k_nouv = ceil(rand*N);
			end

			% Calcul de l'energie correspondant a la nouvelle classe :
			U_nouv = AD(i,j,k_nouv)+a_priori(i,j,k,k_nouv,beta);

			% Recuit simule :
			[k(i,j),U(i,j)] = recuit_simule(k_cour,k_nouv,U_cour,U_nouv,T);
		end
	end

	for i = 1:nb_lignes
		for j = 1:nb_colonnes
			couleurs_pixels(i,j,:) = couleurs_classes(k(i,j),:);
		end
	end
	imagesc(couleurs_pixels);
	axis equal;
	axis off;
	title(['Recuit simule : iteration ' num2str(q) '/' num2str(q_max)],'FontSize',20);
	pause(temps_affichage);

	T = alpha*T;
end

% Calcul du pourcentage de pixels correctement classes :
load classification_OK;
pixels_correctement_classes = find(k==y2);
fprintf('Pixels correctement classes : %.2f %%\n',100*length(pixels_correctement_classes(:))/(nb_lignes*nb_colonnes));
