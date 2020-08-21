%% extract NIR spectrum from 500 data set in mix order 
% similar method to nirtrain.mat 
% if you already have NIR data set, just ignore this file and use spilt
% function directly
%% code
% define the root path of Test Dataset 
clear; 
clc;
path='D:\Master_Maschinenbau\ARP\Paperset\testset\';
%extract the every 350 data for one class
start=0;
nirtest=[];
for i =1:10
    for j =1:50
  
    picpath=strcat(path,num2str(j+start),'.mat');
    load(picpath);
    spec=data.hcam;
    spec(:,225)=i;%label the class number
    new(j,:)=spec;
    end
    nirtest=[nirtest;new];
    start=start+50;
end 