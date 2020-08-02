clear all; 
clc;
load('NIR-Dataset/Durchgefärbt1.mat');
data=spec;
data(:,225)=1;
load('NIR-Dataset/Durchgefärbt2.mat');
new=spec;
new(:,225)=1;
data=[data;new];

load('NIR-Dataset/gKarton1.mat');
new=spec;
new(:,225)=2;
data=[data;new];
load('NIR-Dataset/gKarton2.mat');
new=spec;
new(:,225)=2;
data=[data;new];

load('NIR-Dataset/gPapier1.mat');
new=spec;
new(:,225)=3;
data=[data;new];
load('NIR-Dataset/gPapier2.mat');
new=spec;
new(:,225)=3;
data=[data;new];

load('NIR-Dataset/Magazine1.mat');
new=spec;
new(:,225)=4;
data=[data;new];
load('NIR-Dataset/Magazine2.mat');
new=spec;
new(:,225)=4;
data=[data;new];


load('NIR-Dataset/Wellpappe1.mat');
new=spec;
new(:,225)=5;
data=[data;new];
load('NIR-Dataset/Wellpappe2.mat');
new=spec;
new(:,225)=5;
data=[data;new];

load('NIR-Dataset/Werbehefte1.mat');
new=spec;
new(:,225)=6;
data=[data;new];
load('NIR-Dataset/Werbehefte2.mat');
new=spec;
new(:,225)=6;
data=[data;new];

load('NIR-Dataset/wKarton1.mat');
new=spec;
new(:,225)=7;
data=[data;new];
load('NIR-Dataset/wKarton2.mat');
new=spec;
new(:,225)=7;
data=[data;new];

load('NIR-Dataset/wPapier1.mat');
new=spec;
new(:,225)=8;
data=[data;new];
load('NIR-Dataset/wPapier2.mat');
new=spec;
new(:,225)=8;
data=[data;new];

load('NIR-Dataset/wWellpappe1.mat');
new=spec;
new(:,225)=9;
data=[data;new];

load('NIR-Dataset/Zeitungen1.mat');
new=spec;
new(:,225)=10;
data=[data;new];
load('NIR-Dataset/Zeitungen2.mat');
new=spec;
new(:,225)=10;
data=[data;new];


