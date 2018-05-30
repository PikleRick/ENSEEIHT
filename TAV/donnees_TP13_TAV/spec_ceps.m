function [coefficients_spectre,coefficients_cepstre] = spec_ceps(signal,nb_coefficients,frequence_echantillonnage)
% Cette fonction calcule nb_coefficients coefficients spectraux et autant de coefficients cepstraux


% Fenetre de Hamming :
duree_fenetre = 20*10^(-3);
taille_fenetre = duree_fenetre*frequence_echantillonnage;	% Nombre d'echantillons en 20 millisecondes
fenetre_Hamming = hamming(taille_fenetre);
%fenetre_Hamming = hamming(nb_coefficients);

% Decalage entre fenetres successives (egal a une demi-fenetre) :
decalage = floor(taille_fenetre/2);

% Calcul des coefficients (spectraux et cepstraux) :
longueur_signal = length(signal);
coefficients_spectre = [];
coefficients_cepstre = [];
for x = 1:decalage:longueur_signal-taille_fenetre+1
	signal_fenetre = transpose(signal(x:x+taille_fenetre-1).*fenetre_Hamming);
	spectre_fenetre = abs(fft(signal_fenetre,nb_coefficients));

	% Analyse spectrale :
	coefficients_spectre = [coefficients_spectre ; spectre_fenetre];

	% Analyse cepstrale :
	cepstre_fenetre = ifft(log(spectre_fenetre));
	coefficients_cepstre = [coefficients_cepstre ; cepstre_fenetre];
end
