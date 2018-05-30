function [F1_chapeau,F2_chapeau,a_chapeau] = MV(xy_donnees_bruitees,x_F_aleatoire,y_F_aleatoire,a_aleatoire)


e = @(P,F1,F2,a)(norm(P-F1+ones(2,1),2) + norm(P-F2,2) - (2*a));
F1s(1,:) = x_F_aleatoire(1,:);
F1s(2,:) = y_F_aleatoire(1,:);
F2s(1,:) = x_F_aleatoire(2,:);
F2s(2,:) = y_F_aleatoire(2,:);

%sommeEp = sigma(F1,F2,a);

%function sommeEp = sigma(F1,F2,a)

%e2 = @(P)(e(P,F1,F2,a));

%sommeEp = (sum(arrayfun(xy_donnees_bruitees,e2)));

for i = 1:length(a_aleatoire)
    L(i) = sigma(F1s(:,i),F2s(:,i),a_aleatoire(1,i),xy_donnees_bruitees,e);
end
[Lmin,I] = min(L);
F1_chapeau = F1s(:,I);
F2_chapeau = F2s(:,I);
a_chapeau = a_aleatoire(1,I);