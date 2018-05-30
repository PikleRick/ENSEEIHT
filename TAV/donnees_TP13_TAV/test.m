%% on test sur tout les fichiers son

% % boucler sur tout les fichiers disponibles
% [signal,frequence_echantillonnage] = audioread('/mnt/n7fs/ens/tp_queau/Apprentissage/a_1.wav'); % dans un autre file
% 
% [coefficients_spectre,coefficients_cepstre] = spec_ceps(signal,882,frequence_echantillonnage);
% 
% size(coefficients_spectre)
% size(coefficients_cepstre)

liste_phonemes = {'a','e','e_aigu','e_grave','i','o','o_ouvert','ou','u'};
Lcoeff_s = [];
Lcoeff_c = [];
centresS = [];
centresC = [];

for i = 1:9
    for j = 1:5
        fichier = strcat('/mnt/n7fs/ens/tp_queau/Apprentissage/',liste_phonemes{i},'_',num2str(j),'.wav');
        [signal,frequence_echantillonnage] = audioread(fichier);
        [coefficients_spectre,coefficients_cepstre] = spec_ceps(signal,882,frequence_echantillonnage);
        Mcoeff_spectre = mean(coefficients_spectre,1);
        Mcoeff_cepstre = mean(coefficients_cepstre,1);
        % les ajouter à la liste des coeff
        Lcoeff_s = [Lcoeff_s; Mcoeff_spectre];
        Lcoeff_c = [Lcoeff_c; Mcoeff_cepstre];      
    end
    % calcul des centroides ( tout les 5 elts)
    centresS = [centresS; mean(Lcoeff_s( ((i-1)*5)+1 :((i-1)*5)+5, : ), 1)];
    centresC = [centresC; mean(Lcoeff_c( ((i-1)*5)+1 :((i-1)*5)+5, : ), 1)];
end
% FIN init


%% Classif via Kmeans
[IDs, Cspectre] = kmeans(Lcoeff_s,9, 'Start',centresS);
[IDc, Ccepstre] = kmeans(Lcoeff_c,9, 'Start',centresC);
liste = [];
for i = 1:9
    l = [i,i,i,i,i];
    liste = [liste, l];
end

tauxS = (liste' == IDs);
mean(tauxS)
tauxC = (liste' == IDc);
mean(tauxC)

%% ACP
X = Lcoeff_c;
centre = mean(X);
Xc = X - ones(size(X,1),1)*centre;

sigma = (1/(size(X,1))) * (Xc)'*Xc;
[W,D] = eig(sigma);
[D,Ind] = sort(diag(D), 'descend');
W = W(:,Ind);
im = Xc * W;

%% affichage
couleurs = {'+ y','+ m', '+ c', '+ r', '+ g', '+ b', 'o r', 'o g', 'o b'}; 
figure(1)
hold on;
for i=1:size(im(:,1),1)
    if (IDc(i) == liste(i))
        color = couleurs{IDc(i)};
    else
        color = '. k';
    end
    
    plot(im(i,1), im(i,2), color);
end


        
        