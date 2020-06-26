%feature extraction 
%feature reduction with LDA 
clear;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\ldatrain');
load('E:\ARP\work\NIR_Project\feature extraction\idx');
load('E:\ARP\work\NIR_Project\feature extraction\selectdata');
load('E:\ARP\work\NIR_Project\feature extraction\wavelength');
idx=idx_1(1,1:6);
wavelength=X_d(:,idx);
reduction=NIRldareduced;
%combine the data 
Data=[wavelength, reduction];
Dataselection=[wavelength, reduction(:,7)];



