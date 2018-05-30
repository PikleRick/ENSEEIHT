function X_chapeau = MCT(x,y)
% we'll need a loop here (?)

%x = transpose(xy_donnees_bruitees(1,:));
%y = pareil(2,:);
% alpha + gamma = 1
%A = [x .* y, (y .^2) - (x .^ 2), x, y, 1];
A(:,1) = (x .^ 2);
A(:,2) = x .* y;
A(:,3) = (y .^2);
A(:,4) = x;
A(:,5) = y;
A(:,6) = 1;
[U,S,V] = svd(A);
X_chapeau = V(:,end);
