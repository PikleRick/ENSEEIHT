clear;
close all;

load donnees;
% Calcul des faces du maillage à garder
FACES = [];
n = size(tri, 1);

for i=1:n
    FACES = [FACES; nchoosek(tri(i,:),3)];
end
FACES = sortrows(FACES,'ascend');

removed_ind = [];
for j=1:size(FACES,1)-1
    if all(FACES(k,:) == FACES(j+1,:))
        removed_ind = [removed_ind j+1];
    end
end

ind_faces = setdiff(1:size(FACES,1),removed_ind);
FACES = FACES(ind_faces,:);
fprintf('Calcul du maillage final termine : %d faces. \n',size(FACES,1));

% Affichage du maillage final
figure;
hold on
for i = 1:size(FACES,1)
   plot3([X(1,FACES(i,1)) X(1,FACES(i,2))],[X(2,FACES(i,1)) X(2,FACES(i,2))],[X(3,FACES(i,1)) X(3,FACES(i,2))],'r');
   plot3([X(1,FACES(i,1)) X(1,FACES(i,3))],[X(2,FACES(i,1)) X(2,FACES(i,3))],[X(3,FACES(i,1)) X(3,FACES(i,3))],'r');
   plot3([X(1,FACES(i,3)) X(1,FACES(i,2))],[X(2,FACES(i,3)) X(2,FACES(i,2))],[X(3,FACES(i,3)) X(3,FACES(i,2))],'r');
end;
