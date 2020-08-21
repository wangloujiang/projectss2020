%% extract the NIR spectrum from oringinal dataset
% this file is used to extract the nir data(hcam) from the complete dataset
% it should be used after split the train set and test set totally
% Oringinal dataset is "_Dataset2"
% each class has 350 objects for training
% Finally save the parameter "nirtrain" as nirtrain.mat in workspace in the desired path in your
% computer
% If you already have NIR dataset, just ignore this file
%% code
% define the root path of Training Dataset 
clear; 
clc;
path='D:\Master_Maschinenbau\ARP\Paperset\Trainset\';
%extract the every 350 data for one class
start=0;
nirtrain=[];
for i =1:10
    for j =1:350
  
    picpath=strcat(path,num2str(j+start),'.mat');
    load(picpath);
    spec=data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    nirtrain=[nirtrain;new];
    start=start+350;
end 

