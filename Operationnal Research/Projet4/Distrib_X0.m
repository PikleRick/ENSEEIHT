% Calcul de la distribution initiale du stock PI0 en régime transitoire
% Parametres :		S le stock maximal

% on choisi une distribution de probabilité de loi binomiale
function DistribX = Distrib_X0(S);
p = 0.3;

demandes = 0:S;

DistribX = (binopdf(demandes,S,p))';