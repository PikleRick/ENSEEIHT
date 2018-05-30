% Author : Lilian Calvet (lilian.calvet@gmail.com)

% Basic script that make augmentation from a CCTag
% Image to be augmented must be placed in a folder named 'image'
% using '%05d.jpg' format.
% Augmentation image must be placed in a folder named 'augmentation'
% with the same name as its matched input image from 'image' folder.

close all
addpath('toolbox_augmentation/');
addpath('toolbox_augmentation/toolbox/pgurdjos/');
addpath('toolbox_augmentation/toolbox/vgg/');
eps = 0.02;

%%%%%%% VARIABLES MODIFIABLES %%%%%%%
%%% Vitesse / Precision
n_pts = 30; 	% nb de points sur l'ellipse
pas_frame = 2; % On augmente une frame tous les pas_frame (video originale a 25 fps)

%%% Dossiers ou lire les images, appellees imperativement %05d.jpg

dossier_tag = '/mnt/n7fs/ens/tp_queau/images_tag'; 		% dossier ou se trouvent les %05d.jpg a augmenter
dossier_images = '/mnt/n7fs/ens/tp_queau/images_flamme'; 	% idem. Attention : il faut imperativement que les augmentations aient la meme taille
dossier_resultats='resultats_flamme'; % Dossier ou ecrire les images augmentees pour visualisation apres coup
taille_sequence=300; % nombre de frame dans les sequences (doit etre inferieur au min des deux !)

%%% Affichage en cours de calcul
display_ = 0;	% Affichage des etapes intermediaires
display_results = 1;	% Affichage de l'augmentation


for i= 1:pas_frame:taille_sequence
i



%% Load input image
I = (imread(sprintf('%s/%05d.jpg',dossier_tag,i)));
% Read augmentation image
I_add = (imread(sprintf('%s/%05d.jpg',dossier_images,i)));

if display_
    imshow(I);
end

%% RGB to gray image
I_ng = rgb2gray(I);

if display_
    figure;
    imshow(I_ng);
end

%% Edge detection + Thinning
I_canny = edge(I_ng,'canny');
I_canny = bwmorph(I_canny,'thin');
if display_
    figure;
    imshow(I_canny);
end

%% Labeling
[I_label, n_label] = bwlabel(I_canny);

if display_
    figure;
    imagesc(I_label);
    imshow(I); hold on;
end

%% Select the first edge segment which is an ellipse (outer ellipse C)
k = 1;

for j=1:n_label
    [ ind ] = find(I_label == j);
    
    if length(ind) < 100
        continue;
    end
    
    [y,x] = ind2sub(size(I_label),ind);
    y = y+0.5;
    x = x+0.5;
    
    % FONCTION A ECRIRE ! %
    % param contains the center, radii, and orientation
	% of the ellipse, stored as (Cx, Cy, Rx, Ry, theta_radians)
    % param = estimation_ellipse(x,y);
    % param = fitellipse(x,y);

    % Nouvelle version en 2017 :
    X_chapeau = MCO(x,y);
    [C_chapeau,theta_0_chapeau,a_chapeau,b_chapeau] = conversion(X_chapeau);
    param = [C_chapeau(1) C_chapeau(2) a_chapeau b_chapeau theta_0_chapeau];

    % Extension of C
    param_out = [ param(1:2) param(3:4)+0.05*param(3:4) param(5) ];
    
    % Contraction of C
    param_in = [ param(1:2) param(3:4)-0.05*param(3:4) param(5) ];
    
    C_in = param2ellipse(param_in);
    C_out = param2ellipse(param_out);
    
    pts = augment([ x' ; y' ]);
    
    inlier = [];
    
    for j=1:size(pts,2)
        if (pts(:,j)'*C_out*pts(:,j))*(pts(:,j)'*C_in*pts(:,j)) < 0
            inlier = [ inlier j];
        end
    end
    
    if abs( 1 - length(inlier)/ellipsePerimeter(param) ) < eps
        if display_
            displayEllipse(param);
        end
        C = param2ellipse(param);
        break;
    end
end



pts_ref = ellipsepoints(param,n_pts);
ind_select = zeros(1,n_pts);
for k = 1:n_pts
    distance = sqrt( (pts_ref(1,k) - pts(1,:)).*(pts_ref(1,k) - pts(1,:)) + (pts_ref(2,k) - pts(2,:)).*(pts_ref(2,k) - pts(2,:)) );
    [toto, kmin] = min(distance);
    ind_select(k) = kmin;
end

if display_
    plot(pts_ref(1,:),pts_ref(2,:),'b.');
    plot(pts(1,ind_select),pts(2,ind_select),'r.');
    pause
end

%% Extract subimage to save computation time in Matlab 2D interpolation
[I_ng_sub, pts, C, T, invT ] = extractSubImage(I_ng, pts(1:2,:)', C );
pts = augment(pts');


%% Nonlinear optimization of the center's image
% Has to be updated (fail in some cases)
[H1,im_orig,fsig,Xi] = refineConicFamily(I_ng_sub,C,pts(1:2,ind_select), 100);%,o_init);

H1 = invT*H1;
or = invT*augment(im_orig);
C = T'*C*T;

if display_
    plot(im_orig(1), im_orig(2) , 'g*');
end


im_width = size(I_add,2);
im_height = size(I_add,1);

% World units to pixels transformation
N = vgg_conditioner_from_image(im_width,im_height,min([ im_width im_height ])/2.8);

%% Create Matlab projective transformation
pts_ref = [ -1 -1;  1  -1;  1  1; -1 1];
H2 = H1*N;
im_pts_ref = normalize(H2*augment(pts_ref'));

tform = maketform('projective',pts_ref,im_pts_ref(1:2,:)');
[B,xdata,ydata] = imtransform(I_add, tform, 'bicubic');


%% Augment original image
I_res = zeros(size(I));

figure(20);
imshow(I_res); hold on;
imshow(B,'XData',xdata,'YData',ydata);

F = getframe(gca);
I_res = F.cdata;
I_res = rasterEllipse(C, I, I_res);


fb_makeDirIfNecessary(dossier_resultats,'dir');
fichier_resultat=sprintf('%s/%05d.png',dossier_resultats,i);
imwrite(I_res, fichier_resultat);

if display_
figure;
imshow(I_res);
end

if display_results
	figure(101)
	imshow(I)
	
	figure(102)
	imshow(I_res)
end

end
