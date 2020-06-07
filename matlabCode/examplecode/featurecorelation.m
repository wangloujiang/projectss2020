%% find the coorelation of the different features here,
% result is the feature matrix
x = 1:20;
covariance = cov(results(:,x));
% normalization of the covariance to coorlation
variation = var(results(:,x));
variationmatrix = kron(variation',variation);
squarvariation= sqrt(variationmatrix);
corelation = covariance ./squarvariation;
bar3(corelation);
colorbar;