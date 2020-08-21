%feature extraction by autoencoder 
clear;
clc;
load('D:\Master_Maschinenbau\ARP\work\Final\NIR\data\data3500.mat');
feature=nirtrain(:,1:224);
label=nirtrain(:,225);
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
autoenc=trainAutoencoder(feature,hiddenSize,'MaxEpochs',400);
%evalueate the result: 
feature_Re=predict(autoenc,feature);
mesErro=mse(feature-feature_Re);
fprintf('the mean suquared error is: %f',mesErro);
%generate the reconstructed feature 
featurerecon=encode(autoenc,feature);
featurerecon=[featurerecon',label];
save('autoencoder.mat','autoenc');
save('autoencoder4training.mat','featurerecon');