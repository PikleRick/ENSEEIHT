clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Fenetre d'affichage :
figure('Name','Sequence de realite augmentee','Position',[0.5*L,0,0.5*L,H]);

repertoire_tag = '/mnt/n7fs/ens/tp_queau/images_tag/'; 		% Repertoire ou se trouvent les images a augmenter
repertoire_images = '/mnt/n7fs/ens/tp_queau/images_flamme/'; 	% Idem. Attention : il faut imperativement que les images a augmenter et les augmentations aient la meme taille !
repertoire_resultats = 'resultats_flamme/'; 	% Repertoire ou ecrire les images augmentees pour visualisation

for i = 1:2:300
	fichier_flamme = [repertoire_images num2str(i,'%05d') '.jpg'];
	img_flamme = imread(fichier_flamme);
	subplot(3,1,1);
	imagesc(img_flamme);
	axis xy;
	axis equal;
	axis off;

	fichier_tag = [repertoire_tag num2str(i,'%05d') '.jpg'];
	img_tag = imread(fichier_tag);
	subplot(3,1,2);
	imagesc(img_tag);
	axis equal;
	axis off;

	fichier_aug = [repertoire_resultats num2str(i,'%05d') '.png'];
	img_aug = imread(fichier_aug);
	subplot(3,1,3);
	imagesc(img_aug);
	axis equal;
	axis off;

	pause(0.1);
end
