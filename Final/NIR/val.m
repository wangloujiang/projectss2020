%val
clear;
clc;
load('D:\Master_Maschinenbau\ARP\work\Final\NIR\data\testdata3.mat');

load('plsvector.mat');
load('pcavector.mat');
load('ldavector.mat');
load('autoencoder.mat');

load('meanvalue.mat');
load('stdvalue.mat');
load('meanvaluelda.mat');
load('stdvaluelda.mat');

load('D:\Master_Maschinenbau\ARP\work\Final\NIR\model\svmpls.mat');

%-------------------------pre process------------------------------------%
reponse=testdata3(:,225);
feature=testdata3(:,1:224);
[n,m]=size(feature);
%select ROI 
feature=feature(:,10:210);
%strandarlization according to each row 
feature=zscore(feature,0,2);
%1.Derivate 
derivate=1;
order=3;
window=11;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
    end
%standardlization according to each colum 
feature= (feature-meanvalue)./stdvalue;

%specialization for lda 
featureexlda=testdata3(:,1:224);
responselda=testdata3(:,225);
[n,m]= size(featureexlda);

for i = 1:n
   offset=mean(featureexlda(i,1:10));
    vector(1,1:224)=offset;
    featureexlda(i,:)=featureexlda(i,:)-vector;
    featureldafinal(i,:)=featureexlda(i,10:210);
end
featureldafinal= (featureldafinal-meanvaluelda)./stdvaluelda;
%--------------------------feature extraction----------------------------%
%pls feature extraction
featurepls=feature*v_pls.W;
%pca feature exctraction
featurepca=feature*V_select;
%lda feature extraction
featurelda=featureldafinal*v_lda;
%autoencoder feature extraction 
featureauto=feature';
featureauto=encode(autoenc,featureauto);
featureauto=featureauto';
%combine the features 
features=featurepls;
yfit=svmpls.predictFcn(features);
%Calculation
[a,b]=size(reponse);
difference = (reponse)-yfit;
right = difference(:,1)==0;
S=sum(right);
ratio=S/a;
fprintf('the ratio of prediction is: %8.5f',ratio);
%confusion matrix 
matrix = confusionmat(reponse,yfit);
sumtr = sum(matrix,2);matrix./sumtr;
cm = confusionchart(reponse,yfit, ...
    'Title','Confusion Matrix', ...
    'RowSummary','row-normalized', ...
    'ColumnSummary','column-normalized');
set(gca,'FontSize',22,'Fontname', 'Times New Roman');
xlabel('Predict Value');
ylabel('True Value');
