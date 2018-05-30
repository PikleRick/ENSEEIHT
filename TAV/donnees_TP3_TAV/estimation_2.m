% Estimation des lois normales :
function [delta_moyen,sigma_delta] = estimation_2(beta_estime, gamma_estime)                                                                                                         
% delta_moyen : le point moyen (en terme des ordonnees) pour les beta et
%           les gamma (séparement ?)
% sigma_delta : l'écart-type; pour pas trop s'éloigner de la courbe
% ces deux-là seront calculés statistiquement

beta_moy = mean(beta_estime);
gamma_moy = mean(gamma_estime);
delta_moyen = [beta_moy gamma_moy];

sigma_beta = std(beta_estime, 0);
sigma_gamma = std(gamma_estime, 0);

%sigma_beta = norm(beta_estime - (beta_moy * ones(length(beta_estime))) );
%sigma_beta = sigma_beta / sqrt(length(beta_estime));
%sigma_gamma = norm(gamma_estime - (beta_moy * ones(length(gamma_estime))) );
%sigma_gamma = sigma_gamma / sqrt(length(gamma_estime));

sigma_delta = [sigma_beta sigma_gamma];