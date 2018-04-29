function [ p ] = NormalRegularized( Z,mean,cov,regularize )

if (abs(det(cov)) < 1e-100)
    cov = cov + eye(size(cov,1))*regularize;
end
    n = size(mean,1);
    p = (1/(((2*pi)^(n/2))*sqrt(det(cov))))*exp( -0.5*(Z - mean)*pinv(cov)*(Z - mean)');

end

