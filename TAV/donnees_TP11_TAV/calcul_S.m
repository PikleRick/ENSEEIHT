function [S,taux_compression] = calcul_S(signal,nb_echantillons_par_mesure,proportion)
    
    S = T_Gabor(signal,nb_echantillons_par_mesure);
    
    nLignes = size(S,1);
    nLignesUtiles   = proportion*floor(nLignes/2);
    S((nLignesUtiles + 1):nLignes, :) = 0;
    
    taux_compression = nLignes / nLignesUtiles ;  



end