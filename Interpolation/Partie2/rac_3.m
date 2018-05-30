clear;
close all;
figure('Name', 'Maillage original');

%% les maillages a approximer
% Décommenter un maillage pour appliquer la subdivision

tetra;
% octahedron;
% Lbuilding; 
% apple;
% teapot; 
% steeringwheel; % big
% helix; % big




nb_faces = size(faces, 1);
nb_iter = 2;

% le schema de subdivision racine 3 est un schema de subdivision pour
%  maillage triangulaire
for i = 1:nb_faces
    X = [sommets(faces(i, 1), 1) sommets(faces(i, 2), 1) sommets(faces(i, 3), 1) sommets(faces(i, 1), 1)];
    Y = [sommets(faces(i, 1), 2) sommets(faces(i, 2), 2) sommets(faces(i, 3), 2) sommets(faces(i, 1), 2)];
    Z = [sommets(faces(i, 1), 3) sommets(faces(i, 2), 3) sommets(faces(i, 3), 3) sommets(faces(i, 1), 3)];
    plot3(X, Y, Z, 'r');
    hold on;
end

% Subdivision racine de 3
[s, f] = subdivisions_Rac3(sommets, faces, nb_iter);

% affichage
hold on;
figure('Name','Subdivision racine 3')


for i = 1:nb_faces
    X = [sommets(faces(i, 1), 1) sommets(faces(i, 2), 1) sommets(faces(i, 3), 1) sommets(faces(i, 1), 1)];
    Y = [sommets(faces(i, 1), 2) sommets(faces(i, 2), 2) sommets(faces(i, 3), 2) sommets(faces(i, 1), 2)];
    Z = [sommets(faces(i, 1), 3) sommets(faces(i, 2), 3) sommets(faces(i, 3), 3) sommets(faces(i, 1), 3)];
    plot3(X, Y, Z, 'r');
    hold on;
end

title(['nbIter = ',num2str(nb_iter)])
trisurf(f, s(:, 1), s(:, 2), s(:, 3));
alpha 0.6

hold off; 

figure('Name','Subdivision racine 3 :  Resultat')
trisurf(f, s(:, 1), s(:, 2), s(:, 3));


