function [mu,Sigma] = estimation_mu_Sigma(X)

n = size(X,1);

mu = mean(X);
Xc = X - mu;
Sigma = (Xc' * Xc)/(n);