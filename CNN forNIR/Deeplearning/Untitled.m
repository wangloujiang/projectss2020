%create 4 D Matrix 
clear all;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\testdatarange');
load('E:\ARP\work\NIR_Project\feature extraction\traindatarange');
Xtrain=traindata(1:10,1:224);
Xtrain1=Xtrain'
Xtrain2=reshape(Xtrain1,[224,1,1,10]);
