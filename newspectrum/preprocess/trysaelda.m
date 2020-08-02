%combine the lda and sae 
clear;
clc;
load('Traindata.mat');
feature=traindata(:,1:224);
label=traindata(:,225);
[n,m]=size(feature);
%select ROI 
feature=feature(:,10:210);
%standarlization according to each row 
feature=zscore(feature,0,2);
order=3;
window=11;
derivate=1;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
end
%standardlization according to each colum 
meanvalue=mean(feature);
stdvalue=std(feature);
feature=(feature-meanvalue)./stdvalue;
feature=feature';
%feature extraction 
hiddenSize=10; 
comb3autoenc=trainAutoencoder(feature,hiddenSize);

%generate the reconstructed feature 
featurerecon=encode(comb3autoenc,feature);
featurerecon=featurerecon';

class = unique(label);
classnumber = length(class);
overallmean = mean(featurerecon);
sw = zeros(1,1);
sb = zeros(1,1);
% do the process for each class
for i = 1:classnumber
featurethisid = find(label == class(i));
dataset = featurerecon(featurethisid,:);
meanthis = mean(dataset);
dataset = dataset - repmat(meanthis, length(featurethisid),1);
% between features
sw = sw + dataset'*dataset;
% in features
sb = sb + length(featurethisid)*(meanthis-overallmean)'*(meanthis-overallmean);
end
% get the matrix
matrix = inv(sw)*sb;
% do the analysis
e =  eig(matrix);
[V,D] = eig(matrix);
%Evaluation:
[a,b]= size(D);
Aufsum=sum(D,'all');
sumV=[];
ratio=[];
add=0;

for i=1:a
EV=abs(D(i,i));
add=add+EV;
sumV(i)=add;
ratio(i)=sumV(i)/Aufsum;
end
figure(1)
plot(1:a,ratio,'b-o')
xlabel('number of Eigenvalue');
ylabel('Percentage of main Component');
% wait for selection of main component: 
numComp = input('Select number of Components for lda: ');

v_comb3lda=V(:,1:numComp);
featurercomb=featurerecon*v_comb3lda;
NIRldareducedcomb= [featurercomb,label];

save('comb3saevector.mat','comb3autoenc');
save('comb3ldavector.mat','v_comb3lda');
save('comb34training.mat','NIRldareducedcomb');





