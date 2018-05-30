clear;
close all;

exercice_1;

% Estimation des parametres par les moindres carres ordinaires :
x = transpose(xy_donnees_bruitees(1,:));
y = transpose(xy_donnees_bruitees(2,:));
X_chapeau = MCT(x,y);
[C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau] = conversion(X_chapeau);

X_chapO = MCO(x,y);
[C_chapO,theta_0_chapO,a_chapO,b_chapO] = conversion(X_chapO);

% Affichage de l'ellipse estimee par MCT :
affichage_ellipse(C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau,theta_points_ellipse,'g-',3);
lg = legend(' Ellipse',' Donnees bruitees',' Estimation par MV',' Estimation par MCT','Location','Best');
set(lg,'FontSize',20);

% Calcul du score de l'ellipse estimee par MCT :
R_chapeau = [cos(theta_0_chapeau) -sin(theta_0_chapeau) ; sin(theta_0_chapeau) cos(theta_0_chapeau)];
c_chapeau = sqrt(a_chapeau*a_chapeau-b_chapeau*b_chapeau);


F_1_chapeau = R_chapeau*[c_chapeau ; 0]+C_chapeau;
F_2_chapeau = R_chapeau*[-c_chapeau ; 0]+C_chapeau;
fprintf('Score de l''estimation par MCT = %.3f\n',score(F_1,F_2,a,F_1_chapeau,F_2_chapeau,a_chapeau));

% Calcul du score de l'ellipse estimee par MCO :
R_chapO = [cos(theta_0_chapO) -sin(theta_0_chapO) ; sin(theta_0_chapO) cos(theta_0_chapO)];
c_chapO = sqrt(a_chapO*a_chapO-b_chapO*b_chapO);
F_1_chapO = R_chapO*[c_chapO ; 0]+C_chapO;
F_2_chapO = R_chapO*[-c_chapO ; 0]+C_chapO;
fprintf('Score de l''estimation par MCO = %.3f\n',score(F_1,F_2,a,F_1_chapO,F_2_chapO,a_chapO));
