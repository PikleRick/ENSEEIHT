% REMARQUES :
% E (http://moodle-n7.inp-toulouse.fr/pluginfile.php/45717/mod_resource/content/3/Achanta.pdf)
%   c la moy de la distance entre les anciens et les nouveaux sommets

clear;
close all;

image = double(imread('images/viff.036.ppm'));
[nb_lignes, nb_colonnes, nb_canaux] = size(image);

% Nombre de superpixels
K = 40;
% nb pixels
Nb = nb_lignes * nb_colonnes;
% parametre de la distance SLIC
m = 7;
max_iter = 120;

f = figure('Name', 'Superpixels');
subplot(1,2,1);
imagesc(uint8(image));
pause(0.1);

image = rgb2lab(image/255); %% I = image !!

% mise en format [l a b x y]
X = zeros(Nb, 5);
p = 1;
for i = 1:nb_lignes
    for j = 1:nb_colonnes
        X(p, :) = [image(i, j, 1) image(i, j, 2) image(i, j, 3) i j];
        p = p + 1;
    end
end


%% Algorithm 1 SLIC superpixel segmentation
    % initialisation %
    % Initialize cluster centers Ck = [lk, ak, bk, xk, yk]' by sampling
    % pixels at regular grid steps S.
    S = floor(sqrt(Nb/K)) + 1;
    S_sur_2 = ceil(S / 2);
    pas = floor(S / 2);
    nbL = ceil(nb_lignes / S);
    nbC = ceil(nb_colonnes / S);

centers = zeros(K, 5);
p = 1;
for i = 1:nbL
  for j = 1:nbC
    L = min(pas + (i-1) * S, nbL);
    C = min(pas + (j-1) * S, nbC);
    centers(p, :) = [image(L,C,1) image(L,C,2) image(L,C,3) L C];
    p = p + 1;
    if p > K
        break;
    end
  end
  if p > K
    break;
  end
end

[L,C] = meshgrid(S_sur_2:S:nb_lignes,S_sur_2:S:nb_colonnes);
image_l = image(:,:,1);
image_a = image(:,:,2);
image_b = image(:,:,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Affiner la grille
n=1;
image_g_l = imgradient(image_l);
for k=1:size(centers,1)
   gradient_k = image_g_l(max(centers(k,4)-n,1):min(centers(k,4)+n,nb_lignes),max(centers(k,5)-n,1):min(centers(k,5)+n,nb_colonnes));
   [~, i_min] = min(gradient_k(:));
   [xmin,ymin] = ind2sub(size(gradient_k), i_min);
   x_nouv = centers(k,4) + xmin -n-1;
   y_nouv = centers(k,5) + ymin -n-1;
   centers(k,1) = image_l(round(x_nouv),round(y_nouv));
   centers(k,2) = image_a(round(x_nouv),round(y_nouv));
   centers(k,3) = image_b(round(x_nouv),round(y_nouv));
   centers(k,4) = x_nouv;
   centers(k,5) = y_nouv;    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calcul de Distance SLIC
X(:, 4:5) = X(:, 4:5) * m / S;
centers(:, 4:5) = centers(:, 4:5) * m / S;

[inds, C] = kmeans(X, K, 'start', centers, 'maxiter', max_iter);


C(:, 4:5) = C(:, 4:5) * S / m;
inds = reshape(inds, size(image, 2), size(image, 1))';


pic = zeros(size(image));
for i = 1:size(image, 1)
    for j = 1:size(image, 2)
        id = inds(i, j);
        pic(i, j, 1) = floor(C(id, 1));
        pic(i, j, 2) = floor(C(id, 2));
        pic(i, j, 3) = floor(C(id, 3));
    end
end

% Affichage
subplot(1,2,2);
imagesc(uint8(lab2rgb(pic) * 255));


save superpixels;












