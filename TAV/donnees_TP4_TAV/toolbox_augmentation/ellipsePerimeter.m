function  res = ellipsePerimeter(params)

debug = 0;

if debug
    theta = rand()*pi;
    a = rand()*15;
    b = rand()*22;
    
    params = [ 20 40 a b theta];
    
    pts = ellipsepoints(params, 1000);
    plot(pts(1,:), pts(2,:)); axis equal;
    hold on;
else
    a = params(3);
    b = params(4);
    theta = params(5);
end

A = -b*sin(theta)-b*cos(theta);
B = -a*cos(theta)+a*sin(theta);

t11 = atan2(-A,B);
t12 = t11+pi;

A = -b*sin(theta)+b*cos(theta);
B = -a*cos(theta)-a*sin(theta);

t21 = atan2(-A,B);
t22 = t21+pi;

[x11, y11] = ellipsepoint(params, t11);
[x12, y12] = ellipsepoint(params, t12);
[x21, y21] = ellipsepoint(params, t21);
[x22, y22] = ellipsepoint(params, t22);

if debug
    plot(x11, y11, 'r+');
    plot(x12, y12, 'r+');
    plot(x21, y21, 'r+');
    plot(x22, y22, 'r+');
    
    text(x11+0.5,y11,'p11');
    text(x12+0.5,y12,'p12');
    text(x21+0.5,y21,'p21');
    text(x22+0.5,y22,'p22');
end

x11 = round(x11);
x12 = round(x12);
y11 = round(y11);
y12 = round(y12);
x22 = round(x22);
y22 = round(y22);

%x21 = round(x21);
%y21 = round(y21);

p11 = [ x11;y11];
p22 = [ x22;y22];
p12 = [ x12;y12];

% Determine diffx, diffy

[dum,imax] = max(abs(p22-p11));
if ( imax == 1 )
    diffx = dum;
    [dum,imax] = max(abs(p12-p22));
    diffy = dum;
else
    diffy = dum;
    [dum,imax] = max(abs(p12-p22));
    diffx = dum;
end

% aux = abs(p12-p22)
% [dum,imax] = max(aux);
% 
% if aux(1) ~= aux(2)
%     if ( imax == 1 )
%         diffx = dum;
%     else
%         diffy = dum;
%     end
% else
%     diffx = dum;
%     diffy = dum;
% end

res = (diffx+diffy)*2;

if debug
    hold off;
end


