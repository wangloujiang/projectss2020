clear;
clc
load('Traindata.mat');
load('Testdata.mat');
feature=traindata(:,1:224);
label=traindata(:,225);
[n,m]=size(feature);
responsenew=[];
for i=1:n

    num=label(i);
    new(1,1:10)=0;
    new(1,num)=1;
    responsenew=[responsenew;new];

end
label=responsenew';
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
hiddenSize=50; 
autoenc=trainAutoencoder(feature,hiddenSize);
featurerecon = encode(autoenc,feature);

softnet = trainSoftmaxLayer(featurerecon,label,'MaxEpochs',400);

nirnet=stack(autoenc,softnet);


