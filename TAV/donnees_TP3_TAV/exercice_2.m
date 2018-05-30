clear;
close all;
load exercice_1;
figure('Name','Simulation de silhouettes par tirages aleatoires','Position',[0.33*L,0,0.67*L,H]);

% Estimation des lois normales :
[delta_moyen,sigma_delta] = estimation_2(beta_estime, gamma_estime);                                                                                                          
% delta_moyen : le point moyen (en terme des ordonnees) pour les beta et
%           les gamma (séparement ?)
% sigma_delta : l'écart-type; pour pas trop s'éloigner de la courbe
% ces deux-là seront calculés statistiquement

% Simulation de silhouettes par tirages aleatoires :
N = 40;				% Longueur de la sequence simulee
for k = 1:N
	[x_gauche,x_droite] = simulation(y,beta_0,gamma_0,delta_moyen,sigma_delta,d);

	plot(x_droite,y,'Color','b','LineWidth',2);
	axis([limites(3:4) limites(1:2)]);
	set(gca,'FontSize',20);
	xlabel('$y$','FontSize',30,'Interpreter','Latex');
	ylabel('$x$','FontSize',30,'Interpreter','Latex','Rotation',0);
	hold on;
	plot(x_gauche,y,'Color','b','LineWidth',2);
	for j = 1:p
		plot([x_gauche(j) x_droite(j)],[y(j) y(j)],'Color','b','LineWidth',2);
	end

	pause(0.1);
	hold off;
end

save exercice_2;