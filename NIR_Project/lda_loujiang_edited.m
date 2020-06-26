
%% method of getting lda eigenvalue and eigenvaktor for all
% x as the total result +feature. x=...
clc;clear;
load('NIRTable.mat');
x = NIRdata;
[n,m]= size(x);
feature = x(:,1:m-1);
result = x(:,m);
% get distinct class
class = unique(result);
classnumber = length(class);
overallmean = mean(feature);
sw = zeros(1,1);
sb = zeros(1,1);
% do the process for each class
for i = 1:classnumber
featurethisid = find(result == class(i));
dataset = feature(featurethisid,:);
meanthis = mean(dataset);
dataset = dataset - repmat(meanthis, length(featurethisid),1);
% between features
sw = sw + dataset'*dataset;
% in features
sb = sb + length(featurethisid)*(meanthis-overallmean)'*(meanthis-overallmean);
end
% get the matrix
matrix = inv(sw)*sb;
% do the analysis
e =  eig(matrix);
[V,D] = eig(matrix);
v=V(:,1:6);
feature=feature*v;
NIRldareduced= [feature,result];
%show the result: 
figure(1)
hold on;
scatter(NIRldareduced(1:400,6),NIRldareduced(1:400,5),'filled');
scatter(NIRldareduced(401:782,6),NIRldareduced(401:782,5),'filled');
scatter(NIRldareduced(783:1182,6),NIRldareduced(783:1182,5),'filled');
scatter(NIRldareduced(1183:1582,6),NIRldareduced(1183:1582,5),'filled');
scatter(NIRldareduced(1583:1982,6),NIRldareduced(1583:1982,5),'filled');
scatter(NIRldareduced(1983:2382,6),NIRldareduced(1983:2382,5),'filled');
scatter(NIRldareduced(2383:2674,6),NIRldareduced(2383:2674,5),'filled');
scatter(NIRldareduced(2675:3074,6),NIRldareduced(2675:3074,5),'filled');
scatter(NIRldareduced(3075:3274,6),NIRldareduced(3075:3274,5),'filled');
scatter(NIRldareduced(3275:3674,6),NIRldareduced(3275:3674,5),'filled');
legend('durchgefabrt','gKarton','gPaper','Magazine','Wellpappe','Werbehefte','wKarton','wPapier','wWellpappe','Zeitung');
hold off;
