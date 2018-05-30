function sommeEp = sigma(F1,F2,a,xy_donnees_bruitees,e)

e2 = @(P)(e(P,F1,F2,a));

for i = 1:length(xy_donnees_bruitees)
    T(i) = e2(xy_donnees_bruitees(:,i));
    T(i) = T(i)^2;
end

sommeEp = (sum(T));