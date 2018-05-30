function AD = attache_donnees(I,moyennes,variances)

N = length(moyennes);
[nb_lignes,nb_colonnes] = size(I);
AD = zeros(nb_lignes, nb_colonnes, N);

for i = 1:N
    AD(:,:,i) = 1/2 * ( log(variances(i)) + ( (I - moyennes(i)).^2 / variances(i) ) );
end
