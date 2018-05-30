function sommets = sommetsVoisins(faces, sommet)

nb_faces = size(faces, 1);
sommets = [];

for i = 1:nb_faces
    face = faces(i, :);
    
    if any(face == sommet)
        for j = 1:size(face, 2)
            summit = face(j);
            if summit ~= sommet && all(sommets ~= summit)
                sommets = [sommets summit];
            end
        end
    end
end