load superpixels;
close all;

% % sans prise en compte de la luminance
% couleurs = C(:,2:3);

% prise en compte de la luminance
couleurs = C(:,1:3);

I = kmeans(couleurs, 2);

% calculer l'image binarisée
bin_image = zeros(size(image, 1), size(image, 2));
for i = 1:size(image, 1)
   for j = 1:size(image, 2)
       indices = I(inds(i, j));
       bin_image(i, j) = (indices == 1);
   end
end

%les points de l'objet valent 1
% remarque : il y a moins de points dans l'objet que dans le decor

id_0 = find(bin_image == 0);
id_1 = find(bin_image == 1);
if length(id_0) < length(id_1)
   bin_image = ~bin_image;
end

imshow(bin_image);


save binarisation;


