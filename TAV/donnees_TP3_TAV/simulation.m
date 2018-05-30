function [x_gauche,x_droite] = simulation(y,beta_0,gamma_0,delta_moyen,sigma_delta,d)
% Simulation de silhouettes par tirages aleatoires

x_gauche = 1;
x_droite = -1;
while any(x_gauche > x_droite)
    rand_delta = delta_moyen + sigma_delta .* randn((2*d)-1, 1);
    x_gauche = bezier(y, beta_0, [rand_delta(1:(d-1)) , rand_delta((2*d)-1)]);
    x_droite = bezier(y, gamma_0, rand_delta(d:((2*d)-1)));
end
