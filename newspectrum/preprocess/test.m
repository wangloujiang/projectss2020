%Validation
clear all;
clc;
load('data\testdata.mat');
load('data\ldavector');
load('data\pcavector');
load('data\selectwavelengthnr.mat');
load('data\comb.mat');
   
%generate lda feature
x = testdata(:,1:224);
Responselda=testdata(:,225);
[n,m]= size(x);
featurelda = x(:,1:m);
result =testdata(:,225);
featurelda=medfilt1(featurelda,3,[],2);
featurelda=featurelda*v;


%generate pca feature

pca=testdata(:,1:224);
%Responsepca=testdata(:,225);
[n,m]= size(pca);
featurepca = pca(:,1:m);
featurepca=medfilt1(featurepca,3,[],2);
featurepca=featurepca*V_select;

%Gnerate selection feature 

mrmr=testdata(:,1:224);


X_filt1=medfilt1(mrmr,3,[],2);

%Step 3: normalization 
X_norm=(X_filt1 - mean(X_filt1,2))./std(X_filt1,0,2);

%Step 4: Data Deveriate 
[~,g] = sgolay(2,11);
 for i = 1:size(X_norm,1)    
               X_d(i,:) = conv(X_norm(i,:)', factorial(2) * g(:,2+1), 'same');
  end
mrmr=X_d(:,idx(1:2));

features=[featurelda,featurepca,mrmr];




%Validation with selection
yfit=comb.predictFcn(features);
%Calculation
[a,b]=size(testdata);
difference = result(:,1)-yfit;
right = difference(:,1)==0;
S=sum(right);
ratio=S/a;
%confusion matrix 
matrix = confusionmat(result,yfit);
sumtr = sum(matrix,2);matrix./sumtr;
cm = confusionchart(Responselda,yfit, ...
    'Title','Confusion Matrix', ...
    'RowSummary','row-normalized', ...
    'ColumnSummary','column-normalized');
set(gca,'FontSize',22,'Fontname', 'Times New Roman')