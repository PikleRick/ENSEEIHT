function faceV = faceVoisine(faces, arete, sommet_opp)

faceV = [];
nb_faces = size(faces, 1);

for i = 1:nb_faces
    
    face = faces(i, :);
    a = 1;
    
    for j = 1:length(arete)
        if all(face ~= arete(j))
            a = 0;
            break;
        end
    end
    
    if a
        for j = 1:length(sommet_opp)
            if any(face == sommet_opp(j))
                a = 0;
                break;
            end
        end
    end
    
    if a
        faceV = [faceV i];
    end
end