%Validation
function yfit=val3(testdata,trainmodel)

load('ldavector');
load('pcavector');
load('selectwavelengthnr.mat');
load('plsvector.mat');
load('meanvalue.mat');
load('stdvalue.mat');

   
%generate lda feature
[a,b]=size(testdata);
x2 =testdata(:,1:224);
for i =1:a 
    x2(i,:)=(x2(i,:)-meanvalue)./stdvalue;
end
%x=medfilt1(x,3,[],2);
%order=2;
%framelen=11;
%b = sgolay(order,framelen);
 % for i = 1:size(data_filt1,1)
  %    x=x(i,:);
   %   x_t=x';
    %  ycenter = conv(x_t,b((framelen+1)/2,:),'valid');
     % ybegin = b(end:-1:(framelen+3)/2,:) * x_t(framelen:-1:1);
     % yend = b((framelen-1)/2:-1:1,:) * x_t(end:-1:end-(framelen-1));
     % y = [ybegin; ycenter; yend];
      %x(i,:)=y;
      
               %data_filt2(i,:) = conv(data_filt1(i,:)', factorial(0) * g(:,0+1), 'same');
  %end
  
  for i = 1:a
    offset=mean(x2(i,1:5));
    vector(1,1:224)=offset;
    x2(i,:)=x2(i,:)-vector;
     x(i,:)=x2(i,6:224);
end
%x=normalize(x);

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

%pls
featurepls=x;
featurepls=featurepls*v_pls;

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

%features=[featurelda,featurepca,featurepls,mrmr];
features=[featurepca,featurepls,mrmr];
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
