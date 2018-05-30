clear;
close all;
load exercice_2;
load texture;
figure('Name','Simulation d''une flamme de bougie','Position',[0.33*L,0,0.67*L,H]);

I_max = 255;

% Simulation de flammes :
[nb_lignes_texture,nb_colonnes_texture] = size(texture);
largeur = 1000;				% Largeur de l'image
echelle_en_largeur = 0.5*largeur/(limites(4)-limites(3));
hauteur = 1000;				% Hauteur de l'image
h = round(0.85*hauteur);		% Hauteur de la flamme
y = 0:1/(h-1):1;			% Ordonnees normalisees entre 0 et 1
x_centre = (beta_0+gamma_0)/2;		% Abscisse du centre de la flamme
N = 40;					% Longueur de la sequence simulee
for k = 1:N
	I = zeros(hauteur,largeur);
	[x_gauche,x_droite] = simulation(y,beta_0,gamma_0,delta_moyen,sigma_delta,d);


    for i = 1:h
        n_ligne_texture = round(((nb_lignes_texture*(h-i))+i-1)/(h-1));
        n_col_im_min = floor(L/2+echelle_en_largeur*(x_gauche(i)-x_centre));
        n_col_im_max = ceil(L/2+echelle_en_largeur*(x_droite(i)-x_centre));
        Lflamme = n_col_im_max-n_col_im_min;
        for num_colonne_image = max(n_col_im_min,1):min(n_col_im_max,L)
            colonne_texture = round((num_colonne_image-n_col_im_min)*(nb_colonnes_texture-1)/Lflamme+1);
            I(i,num_colonne_image) = round(texture(n_ligne_texture,colonne_texture)*I_max);
        end
    end

	imagesc(I);
	axis xy;
	axis off;
	colormap(hot);		% Table de couleurs donnant des couleurs chaudes (doc colormap)
	pause(0.1);
end
