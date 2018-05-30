% Quatrième projet RO : Gestio de stocks, Chaines de Markov

% L'objectif est de maximiser le revenu moyen par semaine B(s,S)
% 	en trouvant le meilleur couple (s,S) possible
% ? : avec quoi commencer comme choix de (s,S) et comment incrementer ??
% 	facile : on boucle sur S puis sur s jusqu'à trouver LE max .. :)

t = cputime;
% Initialisation des données
C1 = 5;
C2 = 10;
C3 = 10;
C4 = 5;
v = 20;
% N : plafond du stock maximal S
N = 100;
% Ndem : le nombre maximum de demandes d'articles en une semaine donnée
% 	Il est preferable que Ndem > N pour traiter tout les cas de figure
Ndem = 200;

% ACHTUNG : faut initialiser s et S X)

% La probabilité des demandes ne dépendant pas du temps, on ne générera
%	 sa distribution qu'une fois
Pdemandes = Distrib_D(Ndem);

% Calcul de la distribution de Xn en régime transitoire
% 	on n'aura besoin que de la distribution initiale (fonction de S) et de
% l'indice de n la semaine
% --> voir Distrib_Xn.m


% trouver le revenu moyen maximum (aka. trouver le meilleur couple (s,S))
% 		--> boucle sur S puis sur s
RevenuMoyMax = 0;
Best_s = 0;
Best_S = 0;

for S = 0:N
	for s = 0:S

		% Construction de la matrice de transition P de Xn
		% 	dépends des probabilités de demande en une semaine donnée
		P = Ptransit(s,S,Ndem,Pdemandes);
		
		% distribution initiale du stock
		PI0 = Distrib_X0(S);

        % calcul de la distribution limite
		PI_lim = Dist_lim(PI0, P, 0.001);
		% Calcul du revenu moyen par semaine (en regime permanent)
		BsS = RevenuMoy(s,S,C1,C2,C3,C4,v, Ndem, PI_lim);

		% comparaison
		if RevenuMoyMax < BsS
			RevenuMoyMax = BsS;
			Best_s = s;
			Best_S = S;
		end

	end
end
e = cputime-t;
% finalement, on retourne Best_s et Best_S
% 		avec print ??



