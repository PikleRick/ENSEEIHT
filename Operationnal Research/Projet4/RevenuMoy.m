function BsS = RevenuMoy(s,S,C1,C2,C3,C4,v, Ndem, PI_lim)

Pdemandes = Distrib_D(Ndem);
% Calcul du revenu moyen par semaine (en regime permanent)
B = 0;
% part 1
for j = 0:(s-1)
	SumC2 = 0;
	for k = 1:(Ndem - S)
		SumC2 = SumC2 + (k * Pdemandes(k + S + 1));
	end
	Sumv = 0;
	for k = 1:Ndem
		Sumv = Sumv + min([S k])*Pdemandes(k+1);
	end

	B = B + ( PI_lim(j+1) * (-C1*S - C2*SumC2 - C3 - C4*(S-j) + v*Sumv));
end
% part 2
for j = s:S
	SumC2 = 0;
	for k = 1:(Ndem - j)
		SumC2 = SumC2 + (k * Pdemandes(k + j + 1));
	end
	Sumv = 0;
	for k = 1:Ndem
		Sumv = Sumv + min([j k])*Pdemandes(k+1);
	end

	B = B + ( PI_lim(j+1) * (-C1*j - C2*SumC2 + v*Sumv));
end

BsS = B;