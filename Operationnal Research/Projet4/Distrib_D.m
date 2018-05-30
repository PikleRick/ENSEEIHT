function Pdemandes = Distrib_D(Ndem)
% La probabilité des demandes ne dépendant pas du temps, on ne générera
%	 sa distribution qu'une fois

% On choisi une distribution avec une loi binomiale
p = 0.3;

demandes = 0:Ndem;

Pdemandes = (binopdf(demandes,Ndem,p))';