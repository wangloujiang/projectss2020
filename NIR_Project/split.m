%ML
%Split Data 
load('NIRTable.mat');
X=NIRdata;
m=1;
n=3; 
traindata=X; 
traindata(m:n:end,:)=[];
testdata=X(m:n:end,:);