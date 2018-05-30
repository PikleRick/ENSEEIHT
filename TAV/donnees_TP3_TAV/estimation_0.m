function delta_estime = estimation_0(d,y,x_gauche,beta_0,x_droite,gamma_0)

p = length(y);
for j = 1:p
	for i = 1:d
		A(j,i) = nchoosek(d,i)*y(j)^i*(1-y(j))^(d-i);
	end
end
F = [A zeros(size(A)) ; zeros(size(A)) A];
D = x_gauche-beta_0*(1-y).^d;
E = x_droite-gamma_0*(1-y).^d;
G = [D ; E];

delta_estime = F\G;
