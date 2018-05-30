% edt RechOp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ici on pose la matrice des contraintes d'inégalités A ainsi que 
%  le vecteur correspondant b; on aura dans ce cas (A * x <= b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% initialisation
p = 8;
c = 2;
d = 5;
t = 4;
dt = d * t;
A = zeros(280, p * c * d*t);
b = zeros(280,1);

% numéro de la contrainte courante d'inégalité
numCin = 1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1iere partie de la matrice A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cette partie de A correspond à la 1ière inégalité
% (voir ligne (3) slide n° 53 poly Recherche Opérationnelle)

for j = 1 : c
	for k = 1 : (dt)
		for i = 1 : p
        	A(numCin,indiceEq(i,j,k,p,c))=1;
		end
   		b(numCin)=1;
		numCin = numCin+1;
	end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2ieme partie de la matrice A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cette partie de A correspond à la 2ieme inégalité
% (voir ligne (4) slide n° 53 poly Recherche Opérationnelle)

for i = 1 : p
	for k = 1 : (dt)
		for j = 1 : c
        	A(numCin,indiceEq(i,j,k,p,c))=1;
		end
		b(numCin) = 1;
		numCin = numCin + 1;
	end
end
		



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2ieme partie de la matrice A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cette partie de A correspond à la 2ieme inégalité
% (voir ligne (4) slide n° 53 poly Recherche Opérationnelle)

for i = 1 : p
	for j = 1 : c
		for l = 1 : d
			for k = (l-1)*t+1:l*t
				A(numCin, indiceEq(i,j,k,p,c)) = 1;
			end
       		if(i==4 || i==5)
				b(numCin)=2;
			else 
				b(numCin)=1;
			end
		numCin = numCin + 1;
		end
	end
end




