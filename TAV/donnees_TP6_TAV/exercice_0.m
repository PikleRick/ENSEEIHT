clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Parametres divers :
N = 50;					% Nombre de disques d'une configuration
R = 10;					% Rayon des disques
R_carre = R*R;
nb_points_disque = 30;
increment_angulaire = 2*pi/nb_points_disque;
theta = 0:increment_angulaire:2*pi;
rose = [253 108 158]/255;
q_max = 100000;
nb_valeurs_a_afficher = 10000;
pas_entre_deux_affichages = floor(q_max/nb_valeurs_a_afficher);
temps_affichage = 0.001;

% Lecture et affichage de l'image :
I = imread('colonie.png');
I = rgb2gray(I);
I = double(I);
I = I(100:500,100:500);
[nb_lignes,nb_colonnes] = size(I);
figure('Name',['Detection de ' num2str(N) ' flamants roses'],'Position',[0,0,L,0.65*H]);

% Tirage aleatoire d'une configuration initiale et calcul des niveaux de gris moyens :
abscisses_disques = zeros(N,1);
ordonnees_disques = zeros(N,1);
nvg_moyens_disques = zeros(N,1);
for k = 1:N
	abscisse_nouveau = nb_colonnes*rand;
	ordonnee_nouveau = nb_lignes*rand;
	nvg_moyens_disques(k) = nvg_moyen(abscisse_nouveau,ordonnee_nouveau,R,I);
	abscisses_disques(k) = abscisse_nouveau;
	ordonnees_disques(k) = ordonnee_nouveau;
end
valeurs_q = 0;
nvg_moyen_config = mean(nvg_moyens_disques);
valeurs_nvg_moyen_config = nvg_moyen_config;

% Affichage de la configuration initiale :
subplot(1,2,1);
imagesc(I);
axis image;
axis off;
colormap gray;
hold on;
for k = 1:N
	abscisses_affichage = abscisses_disques(k)+R*cos(theta);
	ordonnees_affichage = ordonnees_disques(k)+R*sin(theta);
	indices = find(abscisses_affichage>0 & abscisses_affichage<nb_colonnes & ...
			ordonnees_affichage>0 & ordonnees_affichage<nb_lignes);
	plot(abscisses_affichage(indices),ordonnees_affichage(indices),'Color',rose,'LineWidth',3);
end
pause(temps_affichage);

% Courbe d'evolution du niveau de gris moyen :
subplot(1,2,2);
plot(valeurs_q,valeurs_nvg_moyen_config,'.','Color',rose);
axis([0 q_max/1000 100 240]);
set(gca,'FontSize',20);
hx = xlabel('Nombre d''iterations','FontSize',30);
hy = ylabel('Niveau de gris moyen','FontSize',30);

% Recherche de la configuration optimale :
for q = 1:q_max
	k = rem(q,N)+1;					% On parcourt les N disques en boucle
	nvg_moyen_courant = nvg_moyens_disques(k);

	% Tirage aleatoire d'un nouveau disque et calcul du niveau de gris moyen :
	abscisse_nouveau = nb_colonnes*rand;
	ordonnee_nouveau = nb_lignes*rand;
	nvg_moyen_nouveau = nvg_moyen(abscisse_nouveau,ordonnee_nouveau,R,I);

	% Si le disque propose est meilleur, mises a jour :
	if nvg_moyen_nouveau>nvg_moyen_courant
		nvg_moyens_disques(k) = nvg_moyen_nouveau;
		abscisses_disques(k) = abscisse_nouveau;
		ordonnees_disques(k) = ordonnee_nouveau;

		hold off;
		subplot(1,2,1);
		imagesc(I);
		axis image;
		axis off;
		colormap gray;
		hold on;
		for k = 1:N
			abscisses_affichage = abscisses_disques(k)+R*cos(theta);
			ordonnees_affichage = ordonnees_disques(k)+R*sin(theta);
			indices = find(abscisses_affichage>0 & abscisses_affichage<nb_colonnes & ...
					ordonnees_affichage>0 & ordonnees_affichage<nb_lignes);
			plot(abscisses_affichage(indices),ordonnees_affichage(indices),'Color',rose,'LineWidth',3);
		end
		pause(temps_affichage);
	end

	% Courbe d'evolution du niveau de gris moyen :
	if rem(q,pas_entre_deux_affichages)==0
		valeurs_q = [valeurs_q q];
		nvg_moyen_config = mean(nvg_moyens_disques);
		valeurs_nvg_moyen_config = [valeurs_nvg_moyen_config nvg_moyen_config];
		subplot(1,2,2);
		plot(valeurs_q,valeurs_nvg_moyen_config,'.-','Color',rose,'LineWidth',3);
		axis([0 max(q_max/1000,1.05*q) 100 240]);
		set(gca,'FontSize',20);
		hx = xlabel('Nombre d''iterations','FontSize',30);
		hy = ylabel('Niveau de gris moyen','FontSize',30);
	end
end
