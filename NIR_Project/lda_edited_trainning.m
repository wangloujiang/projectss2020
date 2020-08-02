
%% method of getting lda eigenvalue and eigenvaktor for all
% x as the total result +feature. x=...
clc;clear;
load('E:\ARP\work\NIR_Project\feature extraction\traindatarange.mat');
x = traindata;
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


