%val
clear;
clc;
load('testdata.mat');

load('plsvector.mat');
load('pcavector.mat');
load('ldavector.mat');
load('combpcavector.mat');
load('combldavector.mat');
load('comb2plsvector.mat');
load('comb2ldavector.mat');
load('autoencoder.mat');
%load('comb3saevector.mat');
%load('comb3ldavector.mat');

load('meanvalue.mat');
load('stdvalue.mat');
load('meanvaluelda.mat');
load('stdvaluelda.mat');

load('svmauto.mat');

%-------------------------pre process------------------------------------%
reponse=testdata(:,225);
feature=testdata(:,1:224);
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
featureexlda=testdata(:,1:224);
responselda=testdata(:,225);
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
%comb feature extraction 
featurecombpca=feature*v_combpca;
featurecomblda=featurecombpca*v_comblda;
%comb2 feature extraction 
featurecomb2pls=feature*v_comb2pls.W;
featurecomb2lda=featurecomb2pls*v_comb2lda;
%autoencoder feature extraction 
featureauto=feature';
featureauto=encode(autoenc,featureauto);
featureauto=featureauto';
%comb3 feature extraction
%featureauto=feature';
%featureauto=encode(comb3autoenc,featureauto);
%featureauto=featureauto';
%featurecomb3=featureauto*v_comb3lda;
%combine the features 
features=featureauto;
yfit=svmauto.predictFcn(features);
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
