function ES = calcul_ES(S,indices_partition,valeurs_t,valeurs_f_S)

S = abs(S);
nb_bandes = length(indices_partition)- 1;

ES = [];
for i = 1:nb_bandes
    [maximums,inds] = max( S(indices_partition(i):indices_partition(i+1)-1, :) );
    
    Seuil = mean(maximums) + std(maximums);
    
    for j = 1:length(maximums)
        if maximums(j) >= Seuil
            ES = [ES; valeurs_t(j) valeurs_f_S(inds(j) + indices_partition(i)-1)];
        end
    end
end

end