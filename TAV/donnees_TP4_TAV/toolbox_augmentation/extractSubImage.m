function [I_ng, pts, Co, T, invT ] = extractSubImage(I_ng, pts, Co )

display_ = 0;

par = ellipse2param(Co);
cx = round(par(1));
cy = round(par(2));
la = round(max(par(3),par(4)));
ma = ceil(min(par(3:4))*1.5);%*0.15

begx = max(cx-la-ma,1);
begy = max(cy-la-ma,1);
endx = min(cx+la+ma,size(I_ng,2));
endy = min(cy+la+ma,size(I_ng,1));

I_ng = I_ng(begy:endy,begx:endx);

% Replace elements in the subimage.

pts = pts - [ (begx - 1)*ones(size(pts,1),1) (begy -1)*ones(size(pts,1),1) ];

Co = param2ellipse([par(1)-begx+1, par(2)-begy+1, par(3:5)]);

if display_
	figure(20);
	imagesc(I_ng);axis equal; colormap gray ; hold on;
	for i=1:size(pts,1)
		plot(pts(i,1),pts(i,2),'g+');
	end
	%pause
	displayEllipse(Co);
end

T = [ 1 0 -begx+1 ; 0 1 -begy+1 ; 0 0 1];
invT = [ 1 0 begx-1 ; 0 1 begy-1 ; 0 0 1];
