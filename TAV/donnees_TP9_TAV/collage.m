function u = collage(r,s,interieur)

% Dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux] = size(r);

r = double(r);
s = double(s);

Creux = ones(size(r, 1), size(r, 2));
Creux(2:end-1, 2:end-1) = 0;

% Operateur gradient :
nb_pixels_r = nb_lignes_r*nb_colonnes_r;
e = ones(nb_pixels_r,1);
Dx = spdiags([-e e],[0 nb_lignes_r],nb_pixels_r,nb_pixels_r);
Dx(nb_pixels_r-nb_lignes_r+1:nb_pixels_r,:) = 0;
Dy = spdiags([-e e],[0 1],nb_pixels_r,nb_pixels_r);
Dy(nb_lignes_r:nb_lignes_r:nb_pixels_r,:) = 0;

% Laplacien
A = -Dx'*Dx - Dy'*Dy;
bord_r = find(Creux == 1);
nb_bord_r = length(bord_r);
A(bord_r,:) = sparse(1:nb_bord_r,bord_r,ones(nb_bord_r,1),nb_bord_r,nb_pixels_r);

% Calcul de l'imagette resultat im, canal par canal :
u = r;
for k = 1:nb_canaux
	u_k = u(:,:,k);
	s_k = s(:,:,k);
    r_k = r(:,:,k);
    
    %%
    rk = r_k(:);
    sk = s_k(:);

    gx = Dx*rk;
    gy = Dy*rk;
    
    gsx = Dx*sk;
    gsy = Dy*sk;
    
    gx(interieur) = gsx(interieur);
    gy(interieur) = gsy(interieur);    
    
    b = -Dx'*gx  - Dy'*gy ;
    b(bord_r) = u_k(bord_r);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    u_k = A \ b;
	u(:,:,k) = reshape(u_k ,nb_lignes_r ,nb_colonnes_r);
    
	%u_k(interieur) = s_k(interieur);
	%u(:,:,k) = u_k;

end
