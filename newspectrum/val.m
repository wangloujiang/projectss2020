clear all;
clc;
load('data\NIR-Validation2.mat');
load('data\ldavector');
load('data\pcavector');
load('data\selectwavelengthnr.mat');
load('data\svm4lda.mat');
   
%generate lda feature
x = spec;
%Responselda=spec(:,225);
[n,m]= size(x);
featurelda = x(:,1:m);
%result = x(:,m);
featurelda=featurelda*v;
yfit=svm4lda.predictFcn(featurelda);