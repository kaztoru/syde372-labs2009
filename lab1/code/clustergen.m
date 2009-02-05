function Y = clustergen (N, mu, sigma)
Y=zeros(N,2);
R = chol(sigma);
Y = repmat(mu,N,1) + randn(N,2)*R;