%ML 
clear all;
clc;
load('lda4training.mat');
load('pca4training.mat');
load('mrmr4training.mat');
features=[NIRldareduced(:,1:6),NIR_featurenew(:,1:6),mrmr4training];
%features=[NIRldareduced(:,1:6),NIR_featurenew(:,1:7)];


