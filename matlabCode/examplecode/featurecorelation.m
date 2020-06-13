%% find the coorelation of the different features here,
clc;clear;
load('loujiangresult.mat')
% result is the feature matrix
x = 1:24;
id = isnan(resultsnew(:,14));
resultsnew(id,:)=[];

covariance = cov(resultsnew(:,x));
% normalization of the covariance to coorlation
variation = var(resultsnew(:,x));
variationmatrix = kron(variation',variation);
squarvariation= sqrt(variationmatrix);
corelation = covariance ./squarvariation;
% eigenvalue and eigenvector
e = eig(covariance);
[V,D] = eig(covariance);

D= D(:,9:24);

modle = resultsnew(:,1:24)*D;
[Y,PS]= mapminmax(modle',-1,1);

modle= [Y' resultsnew(:,25)];

bar3(corelation);
figure;
for i =1:24
subplot(4,6,i);bar(corelation(:,i));title(i);
end


colorbar;
