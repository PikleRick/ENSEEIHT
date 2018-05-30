clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

load musique;

% Calculs preliminaires :
nb_echantillons = length(signal);
duree = floor(nb_echantillons/f_echantillonnage);
duree_mesure = 0.25;					% Duree de la mesure en secondes
nb_mesures = floor(duree/duree_mesure);
nb_echantillons_par_mesure = floor(nb_echantillons/nb_mesures);

% Calcul du sonagramme :
[S,taux_compression] = calcul_S(signal,nb_echantillons_par_mesure,1);

% Selection des elements du sonagramme de plus forte intensite :
n = 400;
[indices_S_max,S_max,taux_compression] = calcul_S_max(signal,nb_echantillons_par_mesure,n);
fprintf('Taux de compression : %.0f\n',taux_compression);

% Affichage du sonagramme original, en guise de comparaison :
figure('Name','Compression audio','Position',[0,0,L,0.6*H]);
subplot 121;
valeurs_t = 0:duree/(nb_mesures-1):duree;
f_max_S = floor(f_echantillonnage/2);
valeurs_f_S = 0:f_max_S/(floor(nb_echantillons_par_mesure/2)-1):f_max_S;
imagesc(valeurs_t,valeurs_f_S,abs(S));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme original','FontSize',20);

% Reconstitution du sonagramme a partir de indice_S_max et S_max :
S_reconstitue = zeros(size(S));
for i = 1:nb_mesures
	indices_max_mesure = indices_S_max(:,i);
	S_reconstitue(indices_max_mesure,i) = S_max(:,i);
end

% Affichage du sonagramme reconstitue :
subplot 122;
imagesc(valeurs_t,valeurs_f_S,abs(S_reconstitue));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
title('Sonagramme reconstitue','FontSize',20);
drawnow;

% Restitution du signal a partir du sonagramme reconstitue :
TG_reconstituee = zeros(nb_echantillons_par_mesure,nb_mesures);
TG_reconstituee((end:-1:end-size(S_reconstitue,1)+1),:) = S_reconstitue;
signal_restitue = real(ifft(TG_reconstituee));		% signal_restitue doit etre reel
signal_restitue = signal_restitue(:);			% signal_restitue doit etre un vecteur
sound(signal_restitue,f_echantillonnage);
