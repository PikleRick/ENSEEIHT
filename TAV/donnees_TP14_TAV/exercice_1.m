clear;
close all;

load donnees;

% Couleur moyenne de chaque image de pensee :
X_pensees = [];
for i = 1:nb_images_pensees
	im = eval(['pe' num2str(i)]);
	X_pensees = [X_pensees ; moyenne(im)];
end

% Couleur moyenne de chaque image d'oeillet :
X_oeillets = [];
for i = 1:nb_images_oeillets
	im = eval(['oe' num2str(i)]);
	X_oeillets = [X_oeillets ; moyenne(im)];
end

% Couleur moyenne de chaque image de chrysantheme :
X_chrysanthemes = [];
for i = 1:nb_images_chrysanthemes
	im = eval(['ch' num2str(i)]);
	X_chrysanthemes = [X_chrysanthemes ; moyenne(im)];
end

% Affichage des couleurs moyennes des images :
pas = 0.0025;
r = 0.35:pas:0.60;
v = 0.2:pas:0.45;
nb_r = length(r);
nb_v = length(v);
figure('Name','Couleurs moyennes des images','Position',[0.5*L,0,0.5*L,0.67*H]);
axis equal;
axis ij;
axis([r(1) r(end) v(1) v(end)]);
hold on;
set(gca,'FontSize',20);
xlabel('$\bar{r}$','Interpreter','Latex','FontSize',30);
ylabel('$\bar{v}$','Interpreter','Latex','FontSize',30);
plot(X_pensees(:,1),X_pensees(:,2),'r*','MarkerSize',10,'LineWidth',2);
plot(X_oeillets(:,1),X_oeillets(:,2),'g*','MarkerSize',10,'LineWidth',2);
plot(X_chrysanthemes(:,1),X_chrysanthemes(:,2),'b*','MarkerSize',10,'LineWidth',2);
legend('Pensees','Oeillets','Chrysantemes','Location','Best');
view(-90,90);

save exercice_1;
