%% find the coorelation of the different features here,
% result is the feature matrix
x = 1:24;
covariance = cov(resultsnew(:,x));
% normalization of the covariance to coorlation
variation = var(resultsnew(:,x));
variationmatrix = kron(variation',variation);
squarvariation= sqrt(variationmatrix);
corelation = covariance ./squarvariation;
bar3(corelation);
figure;
for i =1:24
subplot(4,6,i);bar(corelation(:,i));title(i);
end


colorbar;
