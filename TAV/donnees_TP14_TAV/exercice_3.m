clear;
close all;

load exercice_1;

azimuth = -72;
elevation = 42;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PENSEES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimation des parametres de la loi normale :
[mu_pensees,Sigma_pensees] = estimation_mu_Sigma(X_pensees);
inv_Sigma_pensees = inv(Sigma_pensees);

% Valeurs de la loi normale sur la grille :
V_pensees = zeros(nb_r,nb_v);
for i = 1:nb_r
	for j = 1:nb_v
		r_i = r(i);
		v_j = v(j);
		x_centre = [r_i v_j]-mu_pensees;
		V_pensees(j,i) = exp(-x_centre*inv_Sigma_pensees*x_centre'/2);
	end
end

% Normalisation de la loi normale :
denominateur_classe_pensees = 2*pi*sqrt(det(Sigma_pensees));
V_pensees = V_pensees/denominateur_classe_pensees;

% Representation 3D de la loi normale :
figure('Name','Vraisemblance de la classe "pensees"','Position',[0,0,0.33*L,0.55*H]);
hold on;
surface(r,v,V_pensees,'EdgeColor',[.85 .65 .65],'FaceColor','none');
axis([r(1) r(end) v(1) v(end)]);
view(azimuth,elevation);
rotate3d on;

% Trace des données d'apprentissage de la classe "pensees" (etoiles rouges) :
plot(X_pensees(:,1),X_pensees(:,2),'r*','MarkerSize',10,'LineWidth',2);
set(gca,'FontSize',20);
xlabel('$\bar{r}$','Interpreter','Latex','FontSize',30);
ylabel('$\bar{v}$','Interpreter','Latex','FontSize',30);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OEILLETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimation des parametres de la loi normale :
[mu_oeillets,Sigma_oeillets] = estimation_mu_Sigma(X_oeillets);
inv_Sigma_oeillets = inv(Sigma_oeillets);

% Valeurs de la loi normale sur la grille :
V_oeillets = zeros(nb_r,nb_v);
for i = 1:nb_r
	for j = 1:nb_v
		r_i = r(i);
		v_j = v(j);
		x_centre = [r_i v_j]-mu_oeillets;
		V_oeillets(j,i) = exp(-x_centre*inv_Sigma_oeillets*x_centre'/2);
	end
end

% Normalisation de la loi normale :
denominateur_classe_oeillets = 2*pi*sqrt(det(Sigma_oeillets));
V_oeillets = V_oeillets/denominateur_classe_oeillets;

% Representation 3D de la loi normale :
figure('Name','Vraisemblance de la classe "oeillets"','Position',[0.33*L,0,0.33*L,0.55*H]);
hold on;
surface(r,v,V_oeillets,'EdgeColor',[.65 .85 .65],'FaceColor','none');
axis([r(1) r(end) v(1) v(end)]);
view(azimuth,elevation);
rotate3d on;

% Trace des données d'apprentissage de la classe "oeillets" (etoiles vertes) :
plot(X_oeillets(:,1),X_oeillets(:,2),'g*','MarkerSize',10,'LineWidth',2);
set(gca,'FontSize',20);
xlabel('$\bar{r}$','Interpreter','Latex','FontSize',30);
ylabel('$\bar{v}$','Interpreter','Latex','FontSize',30);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CHRYSANTHEMES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimation des parametres de la loi normale :
[mu_chrysanthemes,Sigma_chrysanthemes] = estimation_mu_Sigma(X_chrysanthemes);
inv_Sigma_chrysanthemes = inv(Sigma_chrysanthemes);

% Valeurs de la loi normale sur la grille :
V_chrysanthemes = zeros(nb_r,nb_v);
for i = 1:nb_r
	for j = 1:nb_v
		r_i = r(i);
		v_j = v(j);
		x_centre = [r_i v_j]-mu_chrysanthemes;
		V_chrysanthemes(j,i) = exp(-x_centre*inv_Sigma_chrysanthemes*x_centre'/2);
	end
end

% Normalisation de la loi normale :
denominateur_classe_chrysanthemes = 2*pi*sqrt(det(Sigma_chrysanthemes));
V_chrysanthemes = V_chrysanthemes/denominateur_classe_chrysanthemes;

% Representation 3D de la loi normale :
figure('Name','Vraisemblance de la classe "chrysanthemes"','Position',[0.66*L,0,0.33*L,0.55*H]);
hold on;
surface(r,v,V_chrysanthemes,'EdgeColor',[.65 .65 .85],'FaceColor','none');
axis([r(1) r(end) v(1) v(end)]);
view(azimuth,elevation);
rotate3d on;

% Trace des données d'apprentissage de la classe "chrysanthemes" (etoiles bleues) :
plot(X_chrysanthemes(:,1),X_chrysanthemes(:,2),'b*','MarkerSize',10,'LineWidth',2);
set(gca,'FontSize',20);
xlabel('$\bar{r}$','Interpreter','Latex','FontSize',30);
ylabel('$\bar{v}$','Interpreter','Latex','FontSize',30);

save exercice_3;
