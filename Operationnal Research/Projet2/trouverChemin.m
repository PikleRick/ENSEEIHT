% retourne un chemin si il existe
% parcours en profondeur



function[chemin] = trouverChemin(i,SUC, NSUC, PRE, NPRE, MARQUE, CAP, CAPMAX, chemin, p)
    dernier = chemin(size(chemin,2));
	if NSUC(i) ~= 0 % le nombre de successeurs de i est non nul
        prsuc = sum(NSUC(1:i-1)) + 1; % prsuc contient l'indice du 1er successeur de i dans SUC
        for k=prsuc:prsuc + NSUC(i)-1  % on parcours les successeurs
            j = SUC(k);
			if ~MARQUE(j) && dernier~= 1
				if CAP(k) < CAPMAX(k) % Si flot non saturé
					MARQUE(j)= true;
					chemin(p)=j;
					if j ~= 1
						chemin = trouverChemin(j,SUC, NSUC, PRE, NPRE, MARQUE, CAP, CAPMAX,chemin, p+1);
						
                    end
                    dernier = chemin(size(chemin,2));
                    if dernier ~= 1 % Si on a pas atteint le bout
							MARQUE(j) = false;
							chemin = chemin(1:p-1);
					end
				end
			end
        end
    end
    dernier = chemin(size(chemin,2));
    if i~=2 && dernier~=1
        if NPRE(i) ~= 0 % le nombre de predecesseurs de i est non nul
            prpre = sum(NPRE(1:i-1)) + 1; % prpre contient l'indice du 1er predecesseur de i dans SUC
            for k=prpre:prpre + NPRE(i)-1  % on parcours les predecesseur
                j = PRE(k);
                if ~MARQUE(j)
                    prsuc = sum(NSUC(1:j-1)) + 1; % prsuc contient l'indice du 1er successeur de j dans SUC
                    for q=prsuc:prsuc + NSUC(j)-1  % on parcours les successeurs
                        if SUC(q) == i
                            if CAP(q) > 0 % Si flot non saturé
                                MARQUE(j)= true;
                                chemin(p)=j;
                                if j ~= 1
                                    chemin = trouverChemin(j,SUC, NSUC, PRE, NPRE, MARQUE, CAP, CAPMAX,chemin, p+1);                              
                                end
                            
                                dernier = chemin(size(chemin,2));
                                if dernier ~= 1 % Si on a pas atteint le bout
                                    MARQUE(j) = false;
                                    chemin = chemin(1:p-1);
                                end
                            end  
						end
					end
				end
			end
        end
    end
	%if chemin(size(chemin,2)) ~= 1 % Si on a pas atteint le bout
	%	chemin = -1; % pas de chemin possible
	%end
end