clear;clc;
% %pca plot 
% load('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\NIR coefficient\Kaolin_PCA_Comp_4.mat')
% total=sum(abs(betaPCR(2:225)));
% weight=betaPCR(2:225)./total;
% x = 1:224;
% plot(x,abs(weight'));


% pca model for features get 
% normalization of the feature
load('featuresloujiang.mat');
[Y,PS] = mapstd(featuresnew,0,1);

% get random Y into model;
random = randperm(size(Y,1));
Y = Y(random(1:4500),:);
[n,p] = size(Y);
% % another standard method
% id = isnan(featuresnew(:,14));
% featuresnew(id,:)=[];
% parameter=zscore(featuresnew);


load('features10KlassenNeueAlgorithmen.mat');
[PCALoadings,PCAScores,PCAVar] = pca(Y,'Economy',false);
length =4;
betaPCR = regress(results(random(1:4500),21)-mean(results(random(1:4500),21)), PCAScores(:,1:length));
betaPCR = PCALoadings(:,1:length)*betaPCR;
betaPCR = [mean(results(:,21)) - mean(Y)*betaPCR; betaPCR];
yfitPCR = [ones(n,1) Y]*betaPCR;

% predict the result
prediction =featuresnew*betaPCR(2:25,1);
% combine the data
featuresnew = [featuresnew prediction];
resultsmodel = [featuresnew results(:,21)];






