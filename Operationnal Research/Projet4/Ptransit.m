
% Construction de la matrice de transition P de Xn
% 	dépends des probabilités de demande en une semaine donnée

function Ptransition = Ptransit(s,S,Ndem,Pdemandes)
% Ndem : le nombre maximum de demandes d'articles en une semaine donnée
% 	Il est preferable que Ndem > N (plafond maximal du stock maximal S) pour traiter tout les cas de figure

% La probabilité des demandes ne dépendant pas du temps, on ne générera
%	 sa distribution qu'une fois



P = zeros(S + 1, S + 1);
for i = 0:S
	if (i >= s)
		for j = 0:S
			if (j == 0)
				% somme "infinie" de i à Ndem
				for k = i:Ndem
					P(i+1,j+1) = P(i+1,j+1) + Pdemandes(k+1);
				end
			elseif (j <= i)
				P(i+1, j+1) = Pdemandes((i-j)+1);
			else
				P(i+1, j+1) = 0;
			end
		end
	else
		for j = 0:S
			if (j == 0)
				% somme "infinie" de S à Ndem
				for k = S:Ndem
					P(i+1,j+1) = P(i+1,j+1) + Pdemandes(k+1);
				end
			else
				P(i+1, j+1) = Pdemandes((S-j)+1);
			end
		end
	end
end

Ptransition = P;
