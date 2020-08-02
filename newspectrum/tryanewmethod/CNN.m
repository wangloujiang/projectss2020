%CNN for classification
clear all;
clc;
load('data\traindata');
load('data\testdata');
Xtrain = traindata(:,1:224);
Ytrain = traindata(:,225);

Xtest = testdata(:,1:224);
Ytest = testdata(:,225);



%Training:
height=1;
[sampleSize,width] = size(Xtrain);
channels=1;

Training=reshape(Xtrain',[width,height, channels, sampleSize]);
Label =categorical(Ytrain);
%Validation:
[sampleSize,width] = size(Xtest);

XValidation=reshape(Xtest',[width,height, channels, sampleSize]);
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