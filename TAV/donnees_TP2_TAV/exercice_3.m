clear;
close all;
load exercice_1;
figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);
s = 6.0e+03;			% Seuil de reconnaissance a regler convenablement

% Tirage aleatoire d'une image de test :
individu = randi(15);
posture = randi(6);
fichier = [chemin '/i' num2str(individu,'%02d') num2str(posture,'%1d') '.mat'];
load(fichier);
img = eval(['i' num2str(individu,'%02d') num2str(posture,'%1d')]);
image_test = double(img(:))';
size(image_test)

% Affichage de l'image de test :
colormap gray;
imagesc(img);
axis image;
axis off;

% Calcul du nombre N de composantes principales a prendre en compte :
diagSigma2 = diag(Sigma_2);
N = 1;
rate = sum(diagSigma2(1:N)) / sum(diagSigma2);
while (rate < 0.95) & (N < (n-1))  
        N = N + 1;
        rate = sum(diagSigma2(1:N)) / sum(diagSigma2);
end

% N premieres composantes principales des images d'apprentissage :
C = X_c*W;
C_N = C(:,1:N);
N
size(C_N)
% N premieres composantes principales de l'image de test :
individu_moyen_test = mean(image_test);

image_test = image_test - repmat(individu_moyen_test,n,1);

Sigma_2_test = (1/n) * (image_test * image_test');

[W_test,D_test] = eig(Sigma_2_test);

[diagD_test, ind] = sort(diag(D_test), 'descend');

W_temp = ones(size(W_test));
W_temp(:,[1,2,3,4,5,6,7,8,9]) = W_test(:,ind);
W_test = W_temp;

W_test = W_test(:,1:(n-1));

W_test = image_test' * W_test;

norme_eigenfaces = sqrt(sum(W_test .^ 2));
W_test  = W_test ./ (ones(p,1) * norme_eigenfaces);
C_test = image_test * W_test;
C_N_test = C_test(:,1:N);
size(C_N_test)

% Determination de l'image d'apprentissage la plus proche :
...

% Affichage du resultat :
if ...<s
	individu_reconnu = ...
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
		['Je reconnais l''individu numero ' num2str(individu_reconnu)]},'FontSize',20);
else
	title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
		'Je ne reconnais pas cet individu !'},'FontSize',20);
end
