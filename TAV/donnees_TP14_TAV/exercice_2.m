clear;
close all;
load exercice_1;

K = 3;
[inds, C] = kmeans([X_pensees; X_oeillets; X_chrysanthemes], K,'emptyaction', 'error', 'start', [mean(X_pensees); mean(X_oeillets); mean(X_chrysanthemes)]);

I = ones(10, 1);

classification = [I; 2 * I; 3 * I];
pourcentage_bonnes_classifs = (sum(inds == classification) / 30) * 100