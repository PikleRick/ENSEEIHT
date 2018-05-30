function delta_estime = estimation_1(d,y,x_gauche,beta_0,x_droite,gamma_0)

p = length(y);
for j = 1:p
	for i = 1:(d-1)
		A(j,i) = nchoosek(d,i)*y(j)^i*(1-y(j))^(d-i);
    end
    B_dd(j,1) = nchoosek(d,d)*y(j)^d*(1-y(j))^(0);
end
F = [A zeros(size(A)) B_dd ; zeros(size(A)) A B_dd];
D = x_gauche-beta_0*(1-y).^d;
E = x_droite-gamma_0*(1-y).^d;
G = [D ; E];

delta_estime = F\G;
