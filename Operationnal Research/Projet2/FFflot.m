%% Algorithme de *Ford-Fulkerson* pour les flots
%
% Representation du graphe
%
% n == nombre de sommets
%
% m == nombre d'arcs
%
% Vecteur du nombre de successeurs de chaque sommet : NSUC
%
% Vecteur des successeurs de chaque sommet : SUC
%
%% Initialisations
NSUC = uint16([1 2 2 1]);
NPRE = uint16([2 1 1 2]);
n = size(NSUC,2);
X = uint16(1:n); % X contient la liste des sommets de G
m = sum(NSUC);
%
% Vecteur des successeurs de chaque sommet : SUC
SUC = uint16([2 3 4 4 1 1]);
% Vecteur des successeurs de chaque sommet : PRE
PRE = uint16([3 4 1 2 3 2 3]);
%
% Vecteur des capacités max de chaque arc
CAPMAX = [inf 1 4 2 5 3];
CAP = [0 0 0 0 0 0];
%

%
MARQUE = false(1,n); % MARQUE est un vecteur logique
MARQUE(2) = true; % on marque le sommet a == 2 ( b == 1 (b,a) == 1)
%

%


%% Algorithme de FF

bloque = false; 

while ~bloque % Tant que chemin possible 

    %% 1.   Trouver chemin
    chemin = [];
    chemin(1)= 2;
	chemin = trouverChemin(2,SUC, NSUC, PRE, NPRE, MARQUE, CAP, CAPMAX, chemin, 2);
	%% 2. Mettre à jour les capicités des flots
    dernier = chemin(size(chemin,2));
    if dernier ~= 1 % Si on a pas atteint le bout
		bloque = true;
	else
		alpha = inf;
		
		% on parcourt des noeuds par lesquels le chemin passe
        ind_cap=[];
		for i = 1:(length(chemin)-1)
			noeud = chemin(i);
			succ = chemin(i+1);
			
			trouve = false;
            if NSUC(noeud) ~= 0
                prsuc = sum(NSUC(1:noeud-1)) + 1; % prsuc contient l'indice du 1er successeur du noeud dans SUC
                k = prsuc;
                while ~trouve && k<=prsuc + NSUC(noeud)-1  % on parcours les successeurs
                    j = SUC(k);
                    if (j == succ) % le flot est dans le bon sens
                        trouve = true;
                        ind_cap(i) = k;
                        alpha = min(alpha, CAPMAX(ind_cap(i)) - CAP(ind_cap(i)));
                    end
                    k = k+1;
                end
            end
            if NSUC(succ) ~= 0
                prsuc = sum(NSUC(1:succ-1)) + 1; % prpre contient l'indice du 1er successuer du successeur dans SUC
                k = prsuc;
                while ~trouve && k<=prsuc + NSUC(succ)-1  % on parcours les successeurs
                    j = SUC(k);
                    if (j == noeud) % le flot est dans le mauvais sens
                        trouve = true;
                        ind_cap(i) = -k;
                        alpha = min(alpha, CAP(-ind_cap(i)));
                    end
                    k = k+1;
                end
			end
		end
		% On augmente les flots

        for i = 1:(length(chemin)-1)
            
            if ind_cap(i) >= 0
                CAP(ind_cap(i)) = CAP(ind_cap(i)) + alpha;
            else
                CAP(-ind_cap(i)) = CAP(-ind_cap(i)) - alpha;
            end
            
        end
        CAP(1) = CAP(1) + alpha
        
    end
end

