%feature extraction 
%feature reduction with LDA 
clear;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\ldatrainrange');
load('E:\ARP\work\NIR_Project\feature extraction\idxrange');
load('E:\ARP\work\NIR_Project\feature extraction\selectdata');
load('E:\ARP\work\NIR_Project\feature extraction\wavelengthrange');
idx=idx_1(1,1:6);
wavelength=X_d(:,idx);
reduction=NIRldareduced;
%combine the data 
Data=[wavelength, reduction];
Dataselection=[wavelength, reduction(:,7)];
Datalda=reduction;



