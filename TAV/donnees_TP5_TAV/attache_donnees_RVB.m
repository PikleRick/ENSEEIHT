function attache = attache_donnees_RVB(I,moys,var_cov_s)

N = size(moys, 2);
[m, n, ~] = size(I);

attache = zeros(m, n, N);

for i = 1:N
    detSigma = sum( diag(var_cov_s(:, :, i)) );
    for j = 1:m
        for k = 1:n
            
            moy = reshape( moys(:,i), 1, 1, 3);
            diff = I(j,k,:) - moy;
            diff = reshape(diff, 3,1);
            
            attache(j,k,i) = 0.5*log(detSigma) + (0.5*diff' * (var_cov_s(:,:,i)\diff));
            
        end
    end
end