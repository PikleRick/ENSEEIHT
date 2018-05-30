function x = strategie(numpart,tx,ty,gx,gy)
% strategie -- Strategie d'un joueur 
%
%  Usage
%    x = strategie(numpart,tx,ty,gx,gy)
%
%  Inputs
%    tx     tableau des strategies jouees par le joueur x
%    ty     tableau des strategies jouees par le joueur y (l'adversaire)
%    gx     tableau des gains du joueur x
%    gy     tableau des gains du joueur y (l'adversaire)
%
%  Outputs
%    x      strategie elaboree par le joueur x
%  
%   strategie pour contrer une strategie affine y(n) = b(d-x(n-1))

if (numpart == 1)
   	s= 0.75;
else
    if ty(numpart-1) == 0.75
        s = noncooperatif(numpart,tx,ty,gx,gy);
    else
        s = strat_eclair(numpart,tx,ty,gx,gy);
    end
end
if (s<0||s>=3)
    x = 0;
else
    x = s;
end;

function x = strat_eclair(numpart,tx,ty,gx,gy)

if numpart < 5 || isequal((ty(numpart-3:numpart-1) == ty(numpart-1)), ones(1,3))
    % si on manque de données ou si y joue toujours la meme chose
    if numpart==1
        s = 0;
    elseif ty(numpart-1) == 0.75
        s = noncooperatif(numpart,tx,ty,gx,gy);
    else
        s = stackelberg(numpart,tx,ty,gx,gy);
    end
else
    % si on detecte une stratégie affine, antiaffine sinon keran2
    tableauDonnees = [ty(numpart-3: numpart-1);tx(numpart-4: numpart-2)];
    tableauDonnees = unique(tableauDonnees','rows')';
    coef = tableauDonnees(1,1)/(3-tableauDonnees(2,1));
    eps = 1e-10;
    utiliseAntiAffine = norm(tableauDonnees(1,:)-coef*(3-tableauDonnees(2,:))) < eps && length(tableauDonnees(1,:))>1 && coef<1 && coef>0;
    if utiliseAntiAffine
        s = (3-ty(numpart-1))/(2-coef);
    else
        %on copie quand on a plus d'idée
        s = strat_copieur(numpart,tx,ty,gx,gy);
    end;
end;

if (s<0||s>=3)
    x = 0;
else
    x = s;
end;

function x = strat_copieur(numpart,tx,ty,gx,gy)

if (numpart == 1)
	x= 0.75;
else
	x = ty(numpart-1);
end;

function x = noncooperatif(numpart,tx,ty,gx,gy)

if (numpart == 1)
	x= 0;
else
	x = (3-ty(numpart-1))/2;
end;

function x = stackelberg(numpart,tx,ty,gx,gy)

if (numpart == 1)
	x= 0;
else
	x = 2*(3-ty(numpart-1))/3;
end; 