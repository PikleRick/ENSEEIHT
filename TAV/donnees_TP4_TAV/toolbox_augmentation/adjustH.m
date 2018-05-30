function H = adjustH(H,C,o,p)

% Transform this world-to-image homography such that the outer circle is centred at the origin and has radius 1
X = transpose(H)*C*H;
par = ellipse2param(X);

bo = normalize(inv(H)*o);
x0 = bo(1); y0  = bo(2);

T = [ 1 0 x0 ; 0 1 y0 ; 0 0 1];
H = H*T;

bp = normalize(inv(H)*p);

s = mean(par(3:4));%norm(bp(1:2));

d  = unit(bp(1:2));
% take the associated direction as the direction of the x-axis on the plane
T  = [s*d(1:2),s*[-d(2);d(1)],[0;0];0,0,1];

H = H*T;


