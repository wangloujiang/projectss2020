clear all; 
clc;
load('E:\ARP\work\NIR_Project\Example_Data_CaCO3_Kaolin.mat');
spectra = dataKaolin;


% sort the Data according to response 
data_sort= sortrows(spectra,225);
data_load= data_sort(:,1:224);
data_response=data_sort(:,225);
wavelength = 939:(1727-939)/223:1727;
%Step 1 Select the Range 
datamin = 1350;
datamax=1500;
idx = (wavelength > datamin) & (wavelength < datamax);
wavelength = wavelength(idx);
data_selected =  data_load(:,idx);
% Step 2 SNV 
data_norm=(data_selected - mean(data_selected,2))./std(data_selected,0,2)
%Step 3: Split Data
 data_load_cal= data_norm;
 data_load_cal(1:3:end,:)=[];
 data_load_val=data_norm(1:3:end,:);
 
 data_response_cal=data_response;
 data_response_cal(1:3:end,:)=[];
 data_response_val=data_response(1:3:end,:);
%Step 4 reshape the Dataset 
height=1;
[sampleSize,width] = size(data_load_cal);
channels=1;

Training=reshape(data_load_cal',[height, width, channels, sampleSize]);
Label = data_response_cal;

[sampleSize,width] = size(data_load_val);

XValidation=reshape(data_load_val',[height, width, channels, sampleSize]);

YValidation =data_response_val;

%Step 5 Create modell
layers =[
imageInputLayer([height,width,channels])
convolution2dLayer([1,5],1,'stride',[1,2])
reluLayer

maxPooling2dLayer([1,10],'Stride',[1,2])

fullyConnectedLayer(6)
dropoutLayer(0.5)
fullyConnectedLayer(1)
regressionLayer
];
%Step 5 caculation:
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



















    
