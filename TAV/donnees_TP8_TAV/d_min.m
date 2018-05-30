%--------------------------------------------------------------------------
% ENSEEIHT - 2IMA - Traitement des donnees Audio-Visuelles
% TP8 - Realite diminuee
% fonction d_min.m :
%--------------------------------------------------------------------------

function [existe_q,bornes_V_p,bornes_V_q_chapeau] = d_min(i_p,j_p,u,D,t,T)

	[nb_lignes,nb_colonnes,nb_canaux] = size(u);

	% Bornes du voisinage de p :
	i_min_p = max(1,i_p-t);
	i_max_p = min(nb_lignes,i_p+t);
	j_min_p = max(1,j_p-t);
	j_max_p = min(nb_colonnes,j_p+t);
	bornes_V_p = [i_min_p i_max_p j_min_p j_max_p];

	% Permet de selectionner les pixels situes a l'interieur de D :
	V_p = ~repmat(D(i_min_p:i_max_p,j_min_p:j_max_p),[1,1,nb_canaux]);

	% Imagette contenue dans le voisinage de p :
	u_p = u(i_min_p:i_max_p,j_min_p:j_max_p,:);

	% Initialisation des parametres :
	existe_q = 0;
	bornes_V_q_chapeau = zeros(1,4);
	d_min = inf;
	
	for i_q = max(1+t,i_p-T+t):min(nb_lignes-t,i_p+T-t)
		
		for j_q = max(1+t,j_p-T+t):min(nb_colonnes-t,j_p+T-t)

			% Voisinage de q (de meme taille que celui de p) :
			i_min_q = i_q+i_min_p-i_p;
			i_max_q = i_q+i_max_p-i_p;
			j_min_q = j_q+j_min_p-j_p;
			j_max_q = j_q+j_max_p-j_p;
			D_q = D(i_min_q:i_max_q,j_min_q:j_max_q);

			% Le pixel q n'est eligible que si tous ses voisins sont dans D :
			if max(D_q(:)) == 0
				
				existe_q = 1;

				% Imagette contenue dans le voisinage de q :
				u_q = u(i_min_q:i_max_q,j_min_q:j_max_q,:);

				% Calcul de la dissemblance d_p_q :
				ecarts = u_p-V_p.*u_q;
				ecarts_vector = ecarts(:);
				d_p_q = ecarts_vector'*ecarts_vector;
				
				if d_p_q < d_min
					
					d_min = d_p_q;
					bornes_V_q_chapeau = [i_min_q i_max_q j_min_q j_max_q];
					
				end
				
			end
		end
		
	end
	
end
