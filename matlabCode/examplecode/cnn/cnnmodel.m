

%% 
inputLayer=imageInputLayer([1 224]);
c1=convolution2dLayer([1 7],2,'stride',1);
p1=maxPooling2dLayer([1 5],'stride',7);



% c2=convolution2dLayer([20 30],400,'numChannels',20);
% p2=maxPooling2dLayer([1 10],'stride',[1 2]);
% f1=fullyConnectedLayer(500);
% f2=fullyConnectedLayer(500);

f1=fullyConnectedLayer(5);
r1=reluLayer;
f2=fullyConnectedLayer(1);

outputLayer=regressionLayer;
convnet=[inputLayer; c1; p1;f1;r1; f2;outputLayer];
opts = trainingOptions('sgdm', 'Plots','training-progress');
convnet = trainNetwork(X,class,convnet,opts);