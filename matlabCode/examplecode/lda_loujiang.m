%% lda method 
clc;clear;
% simple example 
x= [1 2;3 1;-2 -2;-3 -1];
x0 = [1 2;3 1];
x1 =[-2 -2;-3 -1];
totalmean = mean(x);
mean0 = mean(x0);
mean1 = mean(x1);
x0 =x0-repmat(mean0,2,1);
x1 =x1-repmat(mean1,2,1);
sw = x0'*x0+x1'*x1;
sb=2*(mean0-totalmean)'*(mean0-totalmean)...
    +2*(mean1-totalmean)'*(mean1-totalmean);
%% method of getting lda eigenvalue and eigenvaktor for all
% x as the total result +feature. x=...
clc;clear;
load('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\NIR coefficient\NIRTable.mat');
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

