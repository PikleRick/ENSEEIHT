clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture d'un extrait musical :
[signal,f_echantillonnage] = audioread('007.wav');
%sound(signal,f_echantillonnage);
if size(signal,2)==2
	signal = mean(signal,2);		% Conversion stereo -> mono
end

% Calcul de la transformee de Gabor :
nb_echantillons = length(signal);
duree = floor(nb_echantillons/f_echantillonnage);
duree_mesure = 0.2;				% Duree d'une mesure en secondes
nb_mesures = floor(duree/duree_mesure);
valeurs_t = 0:duree/(nb_mesures-1):duree;
nb_echantillons_par_mesure = floor(nb_echantillons/nb_mesures);
TG = T_Gabor(signal,nb_echantillons_par_mesure);

% Bande de frequences audibles :
f_min = 20;
f_max = 2000;
pas_f = f_echantillonnage/nb_echantillons_par_mesure;
valeurs_f_S = 0:pas_f:f_max;
nb_echantillons_f_S = length(valeurs_f_S);

% Calcul du sonagramme complexe :
S = TG(1:nb_echantillons_f_S,:);

% Affichage du sonagramme :
figure('Name','Sonagramme','Position',[0,0,0.5*L,0.67*H]);
imagesc(valeurs_t,valeurs_f_S,abs(S));
axis xy;
set(gca,'FontSize',20);
xlabel('Temps ($s$)','Interpreter','Latex','FontSize',30);
ylabel('Frequence ($Hz$)','Interpreter','Latex','FontSize',30);
drawnow;

% Calcul de la partition frequentielle :
nb_bandes = 6;
partition = exp(log(f_min):(log(f_max)-log(f_min))/nb_bandes:log(f_max));
indices_partition = zeros(1,nb_bandes);
for i = 1:nb_bandes
	indices_partition(i) = min(find(valeurs_f_S>partition(i)));
end
indices_partition(end+1) = length(valeurs_f_S);


% Calcul de l'empreinte sonore :
ES = calcul_ES(S,indices_partition,valeurs_t,valeurs_f_S);

% Affichage de l'empreinte sonore :
figure('Name','Empreinte sonore','Position',[0.5*L,0,0.5*L,0.67*H]);
plot(ES(:,1),log(ES(:,2)/f_min),'o','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
set(gca,'FontSize',20);
xlabel('$t$ ($s$)','Interpreter','Latex','FontSize',30);
ylabel('$\log\left(f/f_{\min}\right)$','Interpreter','Latex','FontSize',30);
axis([valeurs_t(1) valeurs_t(end) 0 log(f_max/f_min)]);
hold on;
for i = 2:length(indices_partition)-1
	plot([valeurs_t(1) valeurs_t(end)],[log(partition(i)/partition(1)) log(partition(i)/partition(1))],'-r');
end
