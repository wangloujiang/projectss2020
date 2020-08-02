clear all;
clc;
load('data/traindata.mat');
X=traindata(:,1:224);
label=traindata(:,225);
%convariance 
X_std=mapstd(X)
X_cov=cov(X_std);
[V,D]=eig(X_cov);
V_select=V(:,219:224);
X_select=X*V_select;
NIR_featurenew=[X_select,label];
