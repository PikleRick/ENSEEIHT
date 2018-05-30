function somme = a_priori(i,j,k,k_ij,beta)
[nb_lignes,nb_colonnes] = size(k);

s=0;

if (i==1 && j==1)
    s = ((k_ij ~= k(i, j+1)) + (k_ij ~= k(i+1, j)) + (k_ij ~= k(i+1, j+1)) );
    
elseif (i==1 && j==nb_colonnes)    
    s = ( (k_ij ~= k(i, j-1)) + (k_ij ~= k(i+1, j-1)) + (k_ij ~= k(i+1, j)) );
    
elseif (i==nb_lignes && j==1)    
    s = ( (k_ij ~= k(i-1, j)) + (k_ij ~= k(i-1, j+1)) + (k_ij ~= k(i, j+1)) );
    
elseif (i==nb_lignes && j==nb_colonnes)    
    s = ( (k_ij ~= k(i, j-1)) + (k_ij ~= k(i-1, j)) + (k_ij ~= k(i-1, j-1)) );
    
elseif (i==1)    
    s = ( (k_ij ~= k(i, j-1))  + (k_ij ~= k(i+1, j+1)) + (k_ij ~= k(i, j+1)) + (k_ij ~= k(i+1, j-1)) + (k_ij ~= k(i+1, j)) );
    
elseif (i==nb_lignes)    
    s = ( (k_ij ~= k(i, j-1)) + (k_ij ~= k(i-1, j)) + (k_ij ~= k(i-1, j+1)) + (k_ij ~= k(i, j+1)) + (k_ij ~= k(i-1, j-1)) );
    
elseif (j==1)    
    s = ( (k_ij ~= k(i-1, j))  + (k_ij ~= k(i+1, j+1)) + (k_ij ~= k(i-1, j+1)) + (k_ij ~= k(i, j+1)) + (k_ij ~= k(i+1, j)) );
    
elseif (j==nb_colonnes)
    s = ( (k_ij ~= k(i, j-1)) + (k_ij ~= k(i-1, j))  + (k_ij ~= k(i-1, j-1)) + (k_ij ~= k(i+1, j-1)) + (k_ij ~= k(i+1, j)) );
    
else
    s = ( (k_ij ~= k(i, j-1)) + (k_ij ~= k(i-1, j))  + (k_ij ~= k(i+1, j+1)) + (k_ij ~= k(i-1, j+1)) + (k_ij ~= k(i, j+1)) + (k_ij ~= k(i-1, j-1)) + (k_ij ~= k(i+1, j-1)) + (k_ij ~= k(i+1, j)) );
end


s = beta * s;

somme = s;
