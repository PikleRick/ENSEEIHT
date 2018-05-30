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

% Calcul du sonagramme :
proportion = 0.25;				% A faire varier entre 0 et 1 
[S,taux_compression] = calcul_S(signal,nb_echantillons_par_mesure,proportion);
fprintf('Coefficient de compression : %.0f\n',taux_compression);

% Affichage du sonagramme :
figure('Name','Sonagramme','Position',[0.1*L,0,0.8*L,0.8*H]);
valeurs_t = 0:duree/(nb_mesures-1):duree;
f_max_S = floor(proportion*f_echantillonnage/2);
valeurs_f_S = 0:f_max_S/(floor(proportion*nb_echantillons_par_mesure/2)-1):f_max_S;
imagesc(valeurs_t,valeurs_f_S,abs(S));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
drawnow;

% Restitution du signal a partir du sonagramme :
TG_reconstituee = zeros(nb_echantillons_par_mesure,nb_mesures);
TG_reconstituee(1:size(S,1),:) = S;
signal_restitue = real(ifft(TG_reconstituee));		% signal_restitue doit etre reel
signal_restitue = signal_restitue(:);			% signal_restitue doit etre un vecteur
sound(signal_restitue,f_echantillonnage);
