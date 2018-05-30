function x = bezier(y,beta_0,beta)

d = length(beta);
x = beta_0*(1-y).^d;
for i = 1:d
	x = x+beta(i)*nchoosek(d,i)*y.^i.*(1-y).^(d-i);
end
