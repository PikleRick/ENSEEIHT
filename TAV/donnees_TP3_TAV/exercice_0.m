clear;
close all;
load donnees;
figure('Name','Modelisation de la silhouette par une paire de courbes de Bezier','Position',[0.33*L,0,0.67*L,H]);

% Degre :
d = 5;

% Modelisation de chaque silhouette par deux courbes de Bezier independantes :
delta = [];
for k = 1:n
	delta_estime = estimation_0(d,y,bords(:,1,k),beta_0,bords(:,2,k),gamma_0);
	beta_estime = delta_estime(1:d);
	gamma_estime = delta_estime(d+1:end);
	x_gauche = bezier(y,beta_0,beta_estime);
	x_droite = bezier(y,gamma_0,gamma_estime);

	plot(y,bords(:,1,k),'r-','LineWidth',2);
	axis(limites);
	axis ij;
	set(gca,'FontSize',20);
	xlabel('$y$','FontSize',30,'Interpreter','Latex');
	ylabel('$x$','FontSize',30,'Interpreter','Latex','Rotation',0);
	hold on;
	plot(y,x_gauche,'b','LineWidth',2);
	plot(y,bords(:,2,k),'r-','LineWidth',2);
	plot(y,x_droite,'b','LineWidth',2);

	pause(0.5);
	hold off;
	delta = [delta ; transpose(delta_estime)];
end
