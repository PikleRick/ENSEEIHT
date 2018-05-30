% Color can be a letter corresponding to the color or an 3 element-array representing RGB 
function [] = displayEllipse(C,color,namedFigure)

if nargin<2
    color = 'g';
end
if nargin>=3
    namedFigure; hold on;
end

if (size(C,1) == 3) && (size(C,2) == 3)
    param = ellipse2param(C);
elseif (size(C,1) == 1) && (size(C,2) == 5)
    param = C
else
    error('First argument in displayEllipse must be of size 5x1 or 3x3');
end
pts = ellipsepoints(param,100000);
if length(color) == 1
	h = plot(pts(1,:),pts(2,:),color);
else
	h = plot(pts(1,:),pts(2,:),'Color',color);
end
set(h,'linewidth',2);
if nargin>=3
	hold off;
end
