%% Non-linear optimization of the center's image. (DIRTY version)

% Input :
% cf ci-dessus
% n : chantillonnage du signal 1D sur une coupe => n niveaux de gris par coupe.

% Output :
% H : optimized homography
% or : optimized center's image
% fsig : collected signals on image cuts after optimization
% Xi : signal abscissa
% p0 : edge points on the outer ellipse

%%
function [H,or,fsig,Xi] = refineConicFamily(I_ng,CO,p0,n)

display_ = 0;

% Conditioning ?
T = eye(3);
invT = inv(T);

p0t = normalize(T*augment(p0));
p0t = p0t(1:2,:);
COt = T'\CO/T;

par = ellipse2param(COt);

X0(1) = par(1);
X0(2) = par(2);

options = optimset('LargeScale','off','Display','iter-detailed');

[X,resnorm] = fminunc(@imOCostFunct,X0,options,I_ng,COt,p0t, invT, n,display_);

or = [ X(1) ; X(2) ; 1];
or = or(1:2);

[fsig , Xi, H] = setSig(CO,[or;1],p0,eye(3),n,I_ng,display_);

for i=1:size(fsig,1)
    varSig(i) = var(fsig(i,:));
end

% Detrompeur
E = param2ellipse([0 0 0.77 0.77 0]);
Cdet = H'\E/H;
pardet = ellipse2param(Cdet);
pts_out = ellipsepoints(pardet,1000);
indDet = sub2ind(size(I_ng),round(pts_out(2,:)),round(pts_out(1,:)));
[dum, imin] = min(I_ng(indDet));

bp = normalize(H\pts_out(:,imin));
theta = atan2(bp(2),bp(1));
t   = linspace(theta-pi/500,theta+pi/500,50);
% Radius detrompeur :
rD = 0.77;
x = rD * cos(t);
y = rD * sin(t);
im_pts = normalize(H*augment([ x ; y ]));
sig_det = interp2(double(I_ng),im_pts(1,:),im_pts(2,:),'bicubic');
[dum, imin] = min(sig_det);


H = adjustH(H,CO,[or;1],im_pts(:,imin));%, p0);
[ dummy , imax ] = max(varSig);
fsig = sum(fsig,1);

end


%% Cost function
function res = imOCostFunct(X,I_ng,CO,p0, invT, n,display_)

res = 0;
o = [X(1);X(2);1];

isig = setSig(CO,o,p0,invT,n,I_ng,display_);

for i=1:size(isig,1)-1
    for j=i+1:size(isig,1)
        res = res + (isig(i,:)-isig(j,:))*(isig(i,:)-isig(j,:))';
    end
end

end


%%
function [isig , Xi, H] = setSig(CO,o,p0,invT,n,I_ng,display_)

isig = [];
Xi = [];
H = [];

A = normalize_matr_det_1(inv(CO));
O = o*o';
vpg = eig(A, o*o');
[dum, imin] = min(abs(vpg));
[U,S,V] = svd(A-vpg(imin)*O);
U = U*sqrt(S);
H = [U(:,1) U(:,2) cross(U(:,1),U(:,2))];
ext = augment(p0(:,1));
H = adjustH(H,CO,o,ext);


H = invT*H;
invH = inv(H);

Xi = linspace(0,1,n);

if display_
    figure(3);
    imagesc(I_ng);axis equal; colormap gray ; hold on;
    for i=1:size(p0,2)
        plot(p0(1,i),p0(2,i),[ color(mod(i,10)+1) 'o']);
    end
    plot(o(1),o(2),'ro');
end

ZI = rectifSignal(I_ng,H,invH, Xi);
isig(1,:) = ZI;

for i=2:size(p0,2)
    ext = augment(p0(:,i));
    d  = normalize(H\ext);
    d  = d/norm(d(1:2));
    T  = [d(1:2),[-d(2);d(1)],[0;0];0,0,1];
    H = H*T;
    invH = inv(H);
    ZI = rectifSignal(I_ng, H, invH, Xi);
    isig(i,:) = ZI;
end

end
