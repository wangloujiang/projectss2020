%feature selection based on MRMC and 
%label addition 
clear;
clc;
load('NIRdata.mat');
NIRdata(1:200,225)=1;
NIRdata(201:600,225)=2;
NIRdata(601:1000,225)=3;
NIRdata(1001:1200,225)=4;
NIRdata(1201:1600,225)=5;
NIRdata(1600:2000,225)=6;
NIRdata(2001:2400,225)=7;

