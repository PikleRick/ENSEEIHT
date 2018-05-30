clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load musique;

% Calculs preliminaires :
nb_echantillons = length(signal);
duree = floor(nb_echantillons/f_echantillonnage);
duree_mesure = 0.25;				% Duree de la mesure en secondes
nb_mesures = floor(duree/duree_mesure);
nb_echantillons_par_mesure = floor(nb_echantillons/nb_mesures);

% Calcul de la transformee de Gabor :
TG = T_Gabor(signal,nb_echantillons_par_mesure);

% Affichage du module de la transformee de Gabor :
figure('Name','Transformee de Gabor','Position',[0.1*L,0,0.8*L,0.8*H]);
valeurs_t = 0:duree/(nb_mesures-1):duree;
f_max = floor(f_echantillonnage/2);
valeurs_f = -f_max:f_max/(nb_echantillons_par_mesure-1):f_max;
imagesc(valeurs_t,valeurs_f,abs(fftshift(TG,1)));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
drawnow;

% Restitution du signal a partir de la transformee de Gabor :
signal_restitue = real(ifft(TG));		% signal_restitue doit etre reel
signal_restitue = signal_restitue(:);		% signal_restitue doit etre un vecteur
sound(signal_restitue,f_echantillonnage);
