function resultat = nvg_moyen(abscisse_nouveau,ordonnee_nouveau,R,I)

[nb_lignes,nb_colonnes] = size(I);
R_carre = R*R;
cpt_pixels = 0;
somme_nvg = 0;
for j = max(1,floor(abscisse_nouveau-R)):min(nb_colonnes,ceil(abscisse_nouveau+R))
	for i = max(1,floor(ordonnee_nouveau-R)):min(nb_lignes,ceil(ordonnee_nouveau+R))
		abscisse_relative = j-abscisse_nouveau;
		ordonnee_relative = i-ordonnee_nouveau;
		if abscisse_relative*abscisse_relative+ordonnee_relative*ordonnee_relative<=R_carre
			cpt_pixels = cpt_pixels+1;
			somme_nvg = somme_nvg+I(i,j);
		end
	end
end
resultat = somme_nvg/cpt_pixels;
