clear all;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\testdatarange');
load('E:\ARP\work\NIR_Project\feature extraction\traindatarange');
Xtrain = traindata(:,1:224);
Ytrain = traindata(:,225);

Xtest = testdata(:,1:224);
Ytest = testdata(:,225);


% Step 2 SNV 
XnormTr=(Xtrain - mean(Xtrain,2))./std(Xtrain,0,2);
XnormTe=(Xtest - mean(Xtest,2))./std(Xtest,0,2);
%Step 3 SG filter 
 [~,g] = sgolay(2,9);
 deriv1=1;
  for i = 1:size(XnormTr,1)    
               X_deriv1(i,:) = conv(XnormTr(i,:)', factorial(deriv1) * g(:,deriv1+1), 'same');
  end
  for i = 1:size(XnormTe,1)    
               X_deriv2(i,:) = conv(XnormTe(i,:)', factorial(deriv1) * g(:,deriv1+1), 'same');
  end

%Step 4 reshape the Dataset 
%Training:
height=1;
[sampleSize,width] = size( X_deriv1);
channels=1;

Training=reshape( X_deriv1',[width,height, channels, sampleSize]);
Label =categorical(Ytrain);
%Validation:
[sampleSize,width] = size(X_deriv2);

XValidation=reshape(X_deriv2',[width,height, channels, sampleSize]);
YValidation =categorical(Ytest);

%Step 5 Create modell
layers =[
imageInputLayer([width,height,channels])
convolution2dLayer([5,1],6,'stride',[2,1])
reluLayer

maxPooling2dLayer([10,1],'stride',[2,1])

fullyConnectedLayer(10)
softmaxLayer
classificationLayer
];
%Step 5 caculation:
opts = trainingOptions('sgdm', ...
    'Plots','training-progress', ...
    'MaxEpochs',50, ...
    'ValidationData',{XValidation,YValidation'},...
    'ValidationFrequency',30,...
    'Verbose',false,...
    'InitialLearnRate',1e-9,...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.2,...
    'LearnRateDropPeriod',5);
net = trainNetwork(Training,Label',layers,opts);

%Step 6 Validation









