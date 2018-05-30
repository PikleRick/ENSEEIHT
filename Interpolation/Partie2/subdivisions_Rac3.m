function [sommets, faces] = subdivisions(sommets, faces, nb_iter)

for i = 1:nb_iter
    [sommets, faces] = aux(sommets, faces);
end

end

% fct auxiliaire : une seule itération de la subdivision ci-dessus
function [sommets, faces] = aux(sommets, faces)


% Calcul des nouveaux sommets (les barycentres des faces)
nb_coord = size(sommets, 2);
nb_faces = size(faces, 1);
barycentres = zeros(nb_faces, nb_coord);
nb_sommets = size(sommets, 1);

for f = 1:nb_faces
    barycentres(f, :) = mean(sommets(faces(f, :), :));
end

% deplacement des sommets (via rotation de la topologie)
nouvSommets = sommets;
for i = 1:nb_sommets
    voisins = sommetsVoisins(faces, i);
    n = length(voisins);
    alpha_n = (4 - 2 * cos(2 * pi / n)) / 9;
    nouvSommets(i, :) = (1 - alpha_n) * sommets(i, :) + alpha_n * sum(sommets(voisins, :)) / n;
end

% Ajout des nouveaux sommets aux anciens
nouvSommets = [nouvSommets; barycentres];

% Calcul des nouvelles faces
nouvFaces = zeros(size(faces, 1) * size(faces, 2), 3);
faces_traitees = zeros(size(faces, 1), 1); % liste des faces déjà traitées
% num courant de la nouvelle face
numFace = 1;


for i = 1:size(faces, 1)
    
    face = faces(i, :);
    
    % pour chaque coté
    for j = 1:size(faces, 2)
        sommet_opp = face(j);
        arete = face([mod(j, size(faces, 2))+1; mod(j+1, size(faces, 2))+1]);
        
        face_vois = faceVoisine(faces, arete, sommet_opp);
        % si il y a une face voisine
        if face_vois ~= 0
            
            if ~faces_traitees(face_vois)
                
                % barycentre de la face courante
                b1 = size(sommets, 1) + i;
                % barycentre de la face voisine
                b2 = size(sommets, 1) + face_vois;
                nouvFaces(numFace, :) = [b1 b2 arete(1)];
                numFace = numFace + 1;
                nouvFaces(numFace, :) = [b1 b2 arete(2)];
                numFace = numFace + 1;
                
            end
        else
            % Sinon on crée alors une seule nouvelle face
            b = size(sommets, 1) + i;
            nouvFaces(numFace, :) = [b arete(1) arete(2)];
            numFace = numFace + 1;
        end
    end
    % On marque alors la face courante comme étant traitée
    faces_traitees(i) = 1;
end

faces = nouvFaces(1:numFace-1, :);
sommets = nouvSommets;

end