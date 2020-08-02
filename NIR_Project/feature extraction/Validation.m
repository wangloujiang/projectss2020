%Validation
clear;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\selectionandldamodel');
load('E:\ARP\work\NIR_Project\feature extraction\testdatarange');
load('E:\ARP\work\NIR_Project\feature extraction\ldavector');
load('E:\ARP\work\NIR_Project\feature extraction\wavelengthtestrange');
%generate lda feature
x = testdata;
[n,m]= size(x);
feature = x(:,1:m-1);
result = x(:,m);
feature=feature*v;
NIRldareduced= [feature,result];
%generate selection feature
TestX=[wavelength,feature];
Response=NIRldareduced(:,7);
%Validation with selection
yfit=selectionandlda.predictFcn(TestX);
%Calculation
[a,b]=size(TestX);
difference = Response(:,1)-yfit;
right = difference(:,1)==0;
S=sum(right);
ratio=S/a;
%confusion matrix 
matrix = confusionmat(Response,yfit);
sumtr = sum(matrix,2);matrix./sumtr;
cm = confusionchart(Response,yfit, ...
    'Title','Confusion Matrix', ...
    'RowSummary','row-normalized', ...
    'ColumnSummary','column-normalized');
set(gca,'FontSize',22,'Fontname', 'Times New Roman')
