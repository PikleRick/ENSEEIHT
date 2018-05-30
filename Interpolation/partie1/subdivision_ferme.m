function [Xres, Yres] = subdivision_ferme(nbIter, degre, X, Y)

% Initialisation 
Xres = zeros(1, 2*length(X)); 
Yres = zeros(1, 2*length(Y)); 


% On réitère nbIter fois 
for i=1:nbIter 
    % Etape 1 :  On double les points 
    Xres = repelem(X,2); 
    Yres = repelem(Y,2); 
    
    % Etape 2 : On prend le milieu de chaque deux points consécutifs
    %           et on repète degre fois.
    for j=1:degre
        X_const = (Xres(1:end-1)+Xres(2:end))/2;
        Xres = [X_const, (Xres(end)+Xres(1))/2]; 
        Y_const = (Yres(1:end-1)+Yres(2:end))/2;
        Yres = [Y_const, (Yres(end)+Yres(1))/2]; 
    end 
    
    X= Xres; 
    Y= Yres; 
end 

Xres = [Xres, Xres(1)]; 

end