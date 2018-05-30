% Brief:
% Compute intersections if there, between a line of equation Y = y and an ellipse C
% Input:
% @C ellipse
% @y ordonate for which x values of intersections are computed 
% Output:
% @x intersections points sort in ascend order

function x = intersectEllipseLine(C,y)

% y index of line, ordonate.
a = C(1,1);
b = 2*(y*C(1,2)+C(1,3));
c = C(2,2)*y^2+2*y*C(3,2)+C(3,3);
discriminant = b^2/4 - a*c;

if discriminant > 0
% "General case" : 2 intersections x1, x2
	sqrtDiscriminant = sqrt(discriminant);
	% Intersection 1
	x(1) = (-b/2-sqrtDiscriminant)/a;
	x(2) = (-b/2+sqrtDiscriminant)/a;
elseif (discriminant == 0)
% 1 point intersection
	x(1) = -b/(2*a);
elseif (discriminant < 0)
% No intersection
	x = [];
end
