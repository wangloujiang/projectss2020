%Validation
clear all;
clc;
load('data\NIR-Validation2.mat');
load('data\ldavector');
load('data\pcavector');
load('data\selectwavelengthnr.mat');
load('data\comb.mat');
   
%generate lda feature
x = spec;
%Responselda=spec(:,225);
[n,m]= size(x);
featurelda = x(:,1:m);
%result = x(:,m);
featurelda=featurelda*v;


%generate pca feature

pca=spec;
%Responsepca=testdata(:,225);
[n,m]= size(pca);
featurepca = pca(:,1:m);
featurepca=featurepca*V_select;

%Gnerate selection feature 

mrmr=spec(:,1:224);


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
%[a,b]=size(spec);
%difference = result(:,1)-yfit;
%right = difference(:,1)==0;
%S=sum(right);
%ratio=S/a;
%confusion matrix 
%matrix = confusionmat(result,yfit);
%sumtr = sum(matrix,2);matrix./sumtr;
%cm = confusionchart(Responselda,yfit, ...
   % 'Title','Confusion Matrix', ...
    %'RowSummary','row-normalized', ...
    %'ColumnSummary','column-normalized');
%set(gca,'FontSize',22,'Fontname', 'Times New Roman')