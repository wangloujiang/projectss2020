%ML 
clear all;
clc;
load('data/lda4training.mat');
load('data/pca4training.mat');
load('data/mrmr4training.mat');
features=[NIRldareduced(:,1:6),NIR_featurenew(:,1:6),mrmr4training];


