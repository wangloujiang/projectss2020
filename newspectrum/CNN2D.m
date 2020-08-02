%CNN for classification
clear all;
clc;
load('data\traindata');
load('data\testdata');
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

%select the data
Xtrainc=X_deriv1(:,15:210);
Xtestc = X_deriv2(:,15:210);

%reform the data
[sampleSize,length]=size(Xtrainc);
 channels=1;
 height=14;
 width=14;
 Training=reshape(Xtrainc',[height,width, channels, sampleSize]);
 [sampleSize2,length2]=size(Xtestc);
 Label=categorical(Ytrain);
 XValidation=reshape(Xtestc',[height,width, channels, sampleSize2]);
 YValidation=categorical(Ytest);
 
 
layers = [
    imageInputLayer([14 14 1])

    convolution2dLayer(3,100,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    averagePooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,100,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    convolution2dLayer(3,100,'Padding','same')
    batchNormalizationLayer
    reluLayer
   
    
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];

opts = trainingOptions('sgdm', ...
    'Plots','training-progress', ...
    'MaxEpochs',50, ...
    'ValidationData',{XValidation,YValidation},...
    'ValidationFrequency',30,...
    'Verbose',false,...
    'InitialLearnRate',1e-9,...
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.2,...
    'LearnRateDropPeriod',5);
net = trainNetwork(Training,Label,layers,opts);
    