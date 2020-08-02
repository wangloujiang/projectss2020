%Validation
function yfit=val3(testdata,trainmodel)

load('ldavector');
load('pcavector');
load('selectwavelengthnr.mat');

   
%generate lda feature
x =testdata(:,1:224);
x=medfilt1(x,3,[],2);
x=normalize(x);
%Responselda=spec(:,225);
[n,m]= size(x);
featurelda = x(:,1:m);
%result = x(:,m);
featurelda=featurelda*v;


%generate pca feature

pca=x;
%Responsepca=testdata(:,225);
[n,m]= size(pca);
featurepca = pca(:,1:m);
featurepca=featurepca*V_select;

%Gnerate selection feature 

mrmr=testdata(:,1:224);


X_filt1=medfilt1(mrmr,3,[],2);

%Step 3: normalization 
%X_norm=normalize(X_filt1);
X_norm2=(X_filt1 - mean(X_filt1,2))./std(X_filt1,0,2);
%Step 4: Data Deveriate 
[~,g] = sgolay(2,11);
 for i = 1:size(X_norm2,1)    
               X_d(i,:) = conv(X_norm2(i,:)', factorial(2) * g(:,2+1), 'same');
  end
mrmr=X_d(:,idx(1:2));

features=[featurelda,featurepca,mrmr];

%Validation with selection
yfit=trainmodel.predictFcn(features);
%Calculation
[a,b]=size(testdata);
difference = testdata(:,225)-yfit;
right = difference(:,1)==0;
S=sum(right);
ratio=S/a;
fprintf('the ratio of prediction is: %8.5f',ratio);
%confusion matrix 
matrix = confusionmat(testdata(:,225),yfit);
sumtr = sum(matrix,2);matrix./sumtr;
cm = confusionchart(testdata(:,225),yfit, ...
    'Title','Confusion Matrix', ...
    'RowSummary','row-normalized', ...
    'ColumnSummary','column-normalized');
set(gca,'FontSize',22,'Fontname', 'Times New Roman');
end
