function [K,U] = recuit_simule(k_cour,k_nouv,U_cour,U_nouv,T)

if U_nouv < U_cour
    K = k_nouv;
    U = U_nouv;
else
    p = rand;
    if p <= exp(-(U_nouv - U_cour)/T)
        K = k_nouv;
        U = U_nouv;
    else
        K = k_cour;
        U = U_cour;
    end
end
