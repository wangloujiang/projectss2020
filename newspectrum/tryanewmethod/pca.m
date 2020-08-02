function pca(traindata)

X=traindata(:,1:224);
label=traindata(:,225);
%Step1: filter
X=medfilt1(X,3,[],2);
X=normalize(X);


%convariance 
X_std=mapstd(X);
X_cov=cov(X_std);
[V,D]=eig(X_cov);
V_select=V(:,219:224);
X_select=X*V_select;
NIR_featurenew=[X_select,label];
save('pca4training.mat','NIR_featurenew');
save('pcavector.mat','V_select');
end

