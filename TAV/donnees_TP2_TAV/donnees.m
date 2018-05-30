clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Donnees','Position',[0.33*L,0,0.67*L,H]);
	
% Choix des images parmi 15 individus et 6 postures faciales :
chemin = '/mnt/n7fs/ens/tp_queau/Images_TP2_TAV';
numeros_individus = [1 4 14];
numeros_postures = [1 3 6];

% Nombre de lignes n de X (nombre d'images selectionnees) :
nb_individus = length(numeros_individus);
nb_postures = length(numeros_postures);
n = nb_individus*nb_postures;

% Nombre de colonnes p de X (nombre de pixels des images) :
fichier = [chemin '/i' num2str(numeros_individus(1),'%02d') num2str(numeros_postures(1),'%1d') '.mat'];
load(fichier);
img = eval(['i' num2str(numeros_individus(1),'%02d') num2str(numeros_postures(1),'%1d')]);
nb_lignes = size(img,1);
nb_colonnes = size(img,2);
p = nb_lignes*nb_colonnes;

% Remplissage de la matrice X :
X = [];
for j = 1:nb_individus
	for k = 1:nb_postures
		fichier = [chemin '/i' num2str(numeros_individus(j),'%02d') num2str(numeros_postures(k),'%1d') '.mat'];
		load(fichier);
		img = eval(['i' num2str(numeros_individus(j),'%02d') num2str(numeros_postures(k),'%1d')]);
		if (size(img,1) ~= nb_lignes) || (size(img,2) ~= nb_colonnes)
			disp('Probleme : les images ne sont pas toutes de meme taille !');
			exit;
		end
		X = [X ; double(img(:))'];
	end
end

% Affichage des images (un individu par ligne, une posture par colonne) :
colormap gray;
for l = 1:n
	j = numeros_individus(floor((l-1)/nb_postures)+1);
	k = numeros_postures(mod((l-1),nb_postures)+1);
	img = reshape(X(l,:),nb_lignes,nb_colonnes);
	subplot(nb_individus,nb_postures,l);
	imagesc(img);
	axis image;
	axis off;
	title(sprintf('Individu %s\nPosture %s',num2str(j,'%2d'),num2str(k,'%1d')),'Fontsize',15);
end

save donnees;
