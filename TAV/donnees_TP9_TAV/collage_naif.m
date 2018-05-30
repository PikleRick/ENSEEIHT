function u = collage_naif(r,s,interieur)

% Dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux] = size(r);

% Calcul de l'imagette resultat im, canal par canal :
u = r;
for k = 1:nb_canaux
	u_k = u(:,:,k);
	s_k = s(:,:,k);
	u_k(interieur) = s_k(interieur);
	u(:,:,k) = u_k;
end
