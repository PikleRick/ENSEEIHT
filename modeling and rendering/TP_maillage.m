clear;
close all;
nb_images = 36; % Nombre d'images

% chargement des images
for i = 1:nb_images
    if i<=10
        nom = sprintf('images/viff.00%d.ppm',i-1);
    else
        nom = sprintf('images/viff.0%d.ppm',i-1);
    end;
    % L'ensemble des images de taille : nb_lignes x nb_colonnes x nb_canaux
    % x nb_images
    im(:,:,:,i) = imread(nom); 
end;
% chargement des points 2D suivis
% pts de taille nb_points x (2 x nb_images)
% sur chaque ligne de pts 
% tous les appariements possibles pour un point 3D donne
% on affiche les coordonnees (xi,yi) de Pi dans les colonnes 2i-1 et 2i
% tout le reste vaut -1
pts = load('viff.xy');
% Chargement des matrices de projection
% Chaque P{i} contient la matrice de projection associee a l'image i 
% RAPPEL : P{i} est de taille 3 x 4
load dino_Ps;
% chargement des masques (pour l'elimination des fonds bleus)
% de taille nb_lignes x nb_colonnes x nb_images
% A COMPLETER quand vous aurez termine la premiere partie permettant de
% binariser les images
load mask;

% Affichage des images
figure;
subplot(2,2,1); imshow(im_mask(:,:,1)); title('Masque image 1');
subplot(2,2,2); imshow(im_mask(:,:,9)); title('Masque image 9');
subplot(2,2,3); imshow(im_mask(:,:,17)); title('Masque image 17');
subplot(2,2,4); imshow(im_mask(:,:,25)); title('Masque image 25');

% Affichage des masques associes
figure;
subplot(2,2,1); imshow(im_mask(:,:,1)); title('Masque image 1');
subplot(2,2,2); imshow(im_mask(:,:,9)); title('Masque image 9');
subplot(2,2,3); imshow(im_mask(:,:,17)); title('Masque image 17');
subplot(2,2,4); imshow(im_mask(:,:,25)); title('Masque image 25');

% Reconstruction des points 3D
X = []; % Contient les coordonnees des points en 3D
color = []; % Contient la couleur associee
% Pour chaque coupple de points apparies
for i = 1:size(pts,1)
    % Recuperation des ensembles de points apparies
    l = find(pts(i,1:2:end)~=-1);
    % Verification qu'il existe bien des points apparies dans cette image
    if size(l,2) > 1 & max(l)-min(l) > 1 & max(l)-min(l) < 36
        A = [];
        R = 0;
        G = 0;
        B = 0;
        % Pour chaque point recupere, calcul des coordonnees en 3D
        for j = l
            A = [A;P{j}(1,:)-pts(i,(j-1)*2+1)*P{j}(3,:);
            P{j}(2,:)-pts(i,(j-1)*2+2)*P{j}(3,:)];
            R = R + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),1,j));
            G = G + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),2,j));
            B = B + double(im(int16(pts(i,(j-1)*2+1)),int16(pts(i,(j-1)*2+2)),3,j));
        end;
        [U,S,V] = svd(A);
        X = [X V(:,end)/V(end,end)];
        color = [color [R/size(l,2);G/size(l,2);B/size(l,2)]];
    end;
end;
fprintf('Calcul des points 3D termine : %d points trouves. \n',size(X,2));

%affichage du nuage de points 3D
figure;
hold on;
for i = 1:size(X,2)
    plot3(X(1,i),X(2,i),X(3,i),'.','col',color(:,i)/255);
end;
axis equal;

% A COMPLETER
% Tetraedrisation de Delaunay
T = DelaunayTri(X(1,:)',X(2,:)', X(3,:)');

% A DECOMMENTER POUR AFFICHER LE MAILLAGE
% fprintf('Tetraedrisation terminee : %d tetraedres trouves. \n',size(T,1));
% Affichage de la tetraedrisation de Delaunay
% figure;
% tetramesh(T);

% A DECOMMENTER ET A COMPLETER

% Calcul des barycentres de chacun des tetraedres
poids = [1, 5, 1, 1, 1; 1, 1, 5, 1, 1; 1, 1, 1, 5, 1; 1, 1, 1, 1, 5];

nb_barycentres = size(poids,2);
for i = 1:size(T,1)
    % Calcul des barycentres differents en fonction des poids differents
    % En commencant par le barycentre avec poids uniformes
    Ti = T(i,:);
    Pi = T.X(Ti,:);
    for k=1:nb_barycentres
        C_g(:,i,k) = [(1/sum(poids(:,k)))*sum(Pi.*(poids(:,k)*ones(1,size(Pi,2))),1) 1]; 
    end
end

% A DECOMMENTER POUR VERIFICATION 
% A RE-COMMENTER UNE FOIS LA VERIFICATION FAITE
% Visualisation pour vérifier le bon calcul des barycentres
% for i = 1:nb_images
%    for k = 1:nb_barycentres
%        o = P{i}*C_g(:,:,k);
%        o = o./repmat(o(3,:),3,1);
%        imshow(im_mask(:,:,i));
%        hold on;
%        plot(o(2,:),o(1,:),'rx');
%        pause;
%        close;
%    end
%end


% A DECOMMENTER ET A COMPLETER
% Copie de la triangulation pour pouvoir supprimer des tetraedres
tri=T.Triangulation;
% Retrait des tetraedres dont au moins un des barycentres 
% ne se trouvent pas dans au moins un des masques des images de travail
% Pour chaque barycentre

removed_ind = [];

for k=1:nb_barycentres
    for i = 1:nb_images
        o = P{i}*C_g(:,:,k);
        o = o./repmat(o(3,:),3,1);

        for i_tetra=1:size(o,2)

            if ~ismember(i_tetra,removed_ind)

                if im_mask(round(o(1,i_tetra)),round(o(2,i_tetra)),i)
                     removed_ind = [removed_ind, i_tetra];
                end

            end
        end
    end    
end
triInd = setdiff(1:size(T,1),removed_ind);
tri = tri(triInd,:);

% A DECOMMENTER POUR AFFICHER LE MAILLAGE RESULTAT
% Affichage des tetraedres restants
fprintf('Retrait des tetraedres exterieurs a la forme 3D termine : %d tetraedres restants. \n',size(tri,1));
figure;
trisurf(tri,X(1,:),X(2,:),X(3,:));

% Sauvegarde des donnees
save donnees;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONSEIL : A METTRE DANS UN AUTRE SCRIPT %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load donnees;
% Calcul des faces du maillage à garder
% FACES = ...;
% ...

% fprintf('Calcul du maillage final termine : %d faces. \n',size(FACES,1));

% Affichage du maillage final
% figure;
% hold on
% for i = 1:size(FACES,1)
%    plot3([X(1,FACES(i,1)) X(1,FACES(i,2))],[X(2,FACES(i,1)) X(2,FACES(i,2))],[X(3,FACES(i,1)) X(3,FACES(i,2))],'r');
%    plot3([X(1,FACES(i,1)) X(1,FACES(i,3))],[X(2,FACES(i,1)) X(2,FACES(i,3))],[X(3,FACES(i,1)) X(3,FACES(i,3))],'r');
%    plot3([X(1,FACES(i,3)) X(1,FACES(i,2))],[X(2,FACES(i,3)) X(2,FACES(i,2))],[X(3,FACES(i,3)) X(3,FACES(i,2))],'r');
% end;
