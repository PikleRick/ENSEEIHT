% @brief Return a binary image from cleared input image I putting 1 values in the elliptic hull associate to ellipse C and of width delta.
% Input :
% @C : ellipse we want to extract points in its hull.
% delta : width of the hull
% @I : binary image cleared to 0 value in which we return 1 values for pixels in the elliptic hull.
% Output :
% @I :  binary image with 1 values for pixels in the elliptic hull.
function [I] = rasterEllipse(C, I, I_add)

% Compute ellipseHull
% C1 outer ellipse of the hull
% C2 inner ellipse of the hull

%[C1 C2] = ellipticHull(C,delta); 

% Loop on ordonates in the image
for i=1:size(I,1)

	% Compute round intersections with line y = i and C1 and C2
	x = round(intersectEllipseLine(C,i));
	%x2 = round(intersectEllipseLine(C2,i));

	% Treat all the cases, respectively (2,2) intersections with (C1,C2), (2,1) intersections with (C1,C2),...
	if ( length(x) == 2 ) 
        
		I(i,x(1):x(2),:) = I_add(i,x(1):x(2),:);
        
	elseif ( length(x) == 1 ) 
        
		I(i,x,:) = I_add(i,x,:);
        
    end
    
end
