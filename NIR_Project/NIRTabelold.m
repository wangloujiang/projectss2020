%feature selection based on MRMC and 
%label addition 
clear;
clc;
load('NIRdata.mat');
NIRdata(1:400,225)=1;
NIRdata(401:782,225)=2;
NIRdata(783:1182,225)=3;
NIRdata(1183:1582,225)=4;
NIRdata(1583:1982,225)=5;
NIRdata(1983:2382,225)=6;
NIRdata(2383:2674,225)=7;
NIRdata(2675:3074,225)=8;
NIRdata(3075:3274,225)=9;
NIRdata(3275:3674,225)=10;

