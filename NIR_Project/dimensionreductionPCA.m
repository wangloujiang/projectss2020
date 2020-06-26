clear all;
clc;
load('NIRTable');
X=NIRdata(:,1:224);
label=NIRdata(:,225);
%convariance 
X_std=mapstd(X)
X_cov=cov(X_std);
[V,D]=eig(X_cov);
V_select=V(:,219:224);
X_select=X*V_select;
NIR_featurenew=[X_select,label];

figure(2);
hold on;
scatter(NIR_featurenew(1:200,6),NIR_featurenew(1:200,5),'filled');
scatter(NIR_featurenew(201:400,6),NIR_featurenew(201:400,5),'filled');
scatter(NIR_featurenew(601:1000,6),NIR_featurenew(601:1000,5),'filled');
scatter(NIR_featurenew(1001:1200,6),NIR_featurenew(1001:1200,5),'filled');
scatter(NIR_featurenew(1201:1600,6),NIR_featurenew(1201:1600,5),'filled');
scatter(NIR_featurenew(1601:2000,6),NIR_featurenew(1601:2000,5),'filled');
scatter(NIR_featurenew(2001:2400,6),NIR_featurenew(2001:2400,5),'filled');
hold off;