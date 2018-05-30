% edt RechOp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ici on pose la matrice des contraintes d'égalités Aeq ainsi que 
%  le vecteur correspondant beq; on aura dans ce cas (Aeq * x = beq)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%initialisation
p = 8;
c = 2;
d = 5;
t = 4;
dt = d * t;
Aeq = zeros(44, p * c * d*t);
beq = zeros(44,1);

% le numéro de la contrainte d'égalité courante
numCeq = 1;


% cette partie de beq correspond à l'égalité (2) (voir slide n° 53 poly Recherche Opérationnelle)
% concrètement cela représente le nombre de cours donné par le prof i à la promo j
% (voir aussi "feuille de route")
beq(numCeq:numCeq+p*c-1)=[5;0;0;4;3;3;6;0;0;6;3;3;1;0;0;1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1iere partie de la matrice Aeq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:p
    for j=1:c
		for k=1:dt
        		Aeq(numCeq,indiceEq(i,j,k,p,c))=1;
		end
		numCeq = numCeq + 1;
	end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2ieme partie de la matrice Aeq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Les cours de sport ont lieu le jeudi après-midi de 14h à 16h.
%les profs de sport sont (i=7)Melle Gazelle et (i=8)Mr Bigceps

Aeq(numCeq,indiceEq(7,1,15,p,c))=1;

beq(numCeq)=1;
numCeq = numCeq + 1;

Aeq(numCeq,indiceEq(8,2,15,p,c))=1;

beq(numCeq)=1;
numCeq = numCeq + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3ieme partie des contraintes d'egalites
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cette partie de Aeq correspond à l'égalité (8) 
% (voir slide n° 53 poly Recherche Opérationnelle)

for i=1:p
    for j=1:c
        Aeq(numCeq,indiceEq(i,j,1,p,c))=1;
		beq(numCeq)=0;
		numCeq=numCeq+1;
	end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4ieme partie de la matrice Aeq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cette partie de Aeq correspond à l'égalité (9) 
% (voir slide n° 53 poly Recherche Opérationnelle)

for k=1:2
    Aeq(numCeq,indiceEq(2,2,k,p,c))=1;
	beq(numCeq)=0;
	numCeq = numCeq + 1;
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5ieme partie de la matrice Aeq
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cette partie de Aeq correspond à l'égalité (10)
% (voir slide n° 53 poly Recherche Opérationnelle)

for j=1:2
	for k=9:12
       	Aeq(numCeq,indiceEq(3,j,k,p,c))=1;
		beq(numCeq) = 0;
		numCeq = numCeq + 1;
	end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calcul de la soution du problème d'optimisation : 
%                                                   min (f' * x)
%                                                   A.x <= b 
%                                                   Aeq.x = beq
%                                                   lb <= x <= ub
% x étant le vecteur solution de notre problème (dans ce cas, la minimisation du nombre
% de trous dans un emploi du temps donné)

matriceA;
colonneF;

x = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

% l'exemple traité se limite à 2 promo, mais il est généralisable assez facilement
Promo1=zeros(4,5);
Promo2=zeros(4,5);
for i=1:p
    for j=1:c
        for l=1:d
            for m=1:t
                if(x(indiceEq(i,j,(l-1)*t+m,p,c))==1)
                    if j==1
                        Promo1(m,l)=i;
                    elseif j==2
                         Promo2(m,l)=i;
                    end
                end
            end
        end
    end
end