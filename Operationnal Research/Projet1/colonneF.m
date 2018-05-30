% edt RechOp

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f est la fonction (vecteur) à minimiser
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialisation

p = 8;
c = 2;
d = 5;
t = 4;

f = zeros(p*c*d*t,1);


for i = 1 : p
	for j = 1 : c
		for l = 0 : (d - 1)
        		f(indiceEq(i,j,l*t+1,p,c))=1;
                f(indiceEq(i,j,l*t+t,p,c))=1;
        end
	end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% on cherche x telle que (lb <= x <= ub); intcon contient les indices de x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lb = zeros(p*c*d*t,1);
ub = ones(p*c*d*t,1);
intcon=1:p*c*dt;