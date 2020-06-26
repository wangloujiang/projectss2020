%Validation
clear;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\selection');
load('E:\ARP\work\NIR_Project\feature extraction\ldatest');
load('E:\ARP\work\NIR_Project\feature extraction\wavelengthtest');
Test=wavelength;
TestX=Test;
Response=NIRldareduced(:,7);
yfit=selectionmodel.predictFcn(TestX);
%Calculation
[a,b]=size(Test);
difference = Response(:,1)-yfit;
right = difference(:,1)==0;
S=sum(right);
ratio=S/a;
