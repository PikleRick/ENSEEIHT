function X_chapeau = MCO(x,y)
% we'll need a loop here (?)

%x = transpose(xy_donnees_bruitees(1,:));
%y = pareil(2,:);
% alpha + gamma = 1
%A = [x .* y, (y .^2) - (x .^ 2), x, y, 1];
A(:,1) = x .* y;
A(:,2) = (y .^2) - (x .^ 2);
A(:,3) = x;
A(:,4) = y;
A(:,5) = 1;
b = - (x .^ 2);

X = A \ b;
X_chapeau = zeros(6,1);
X_chapeau(1) = 1 - X(2);
X_chapeau(2:6,1) = X';