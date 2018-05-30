function [rx, ry] = ellipsepoint(params, t)

x = params(3) * cos(t);
y = params(4) * sin(t);
rx  = x*cos(params(5))-y*sin(params(5)) + params(1); 
ry  = x*sin(params(5))+y*cos(params(5)) + params(2);
