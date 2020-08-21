%% Split the total dataset 
%spilt the first 50 objects in every class used for testdata
%use the rest 350 project in every class und rename the number from 1 to
%350
%% code
% define the root path of Dataset with sequence scan order
clear; 
clc;
pathdata='D:\Master_Maschinenbau\ARP\_Dataset2\';
pathtest='D:\Master_Maschinenbau\ARP\Paperset\Testset\';
pathtrain='D:\Master_Maschinenbau\ARP\Paperset\Trainset\';
Trainidx=1;
Testidx=1;
%wPaper:1
for i = 1:400

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >0 & i < 51
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end
%gPaper:2
for i = 401:800

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >400 & i < 451
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end
%Newspaper:3
for i = 801:1200

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >800 & i < 851
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end
%Magazine:4
for i = 1201:1600

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >1200 & i < 1251
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end
%Werbehefte:5
for i = 1601:2000

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >1600 & i < 1651
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end
%color paper:6
for i = 2001:2400

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >2000 & i < 2051
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end
%wKartion:7
for i = 2401:2800

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >2400 & i < 2451
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end

%gKarton: 8 
for i = 2801:3200

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >2800 & i < 2851
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end

%gWellepaper: 9 
for i = 3201:3600

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >3200 & i < 3251
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end

%wWellepaper: 10 
for i = 3601:4000

datapath=strcat(pathdata,num2str(i),'.mat');
load(datapath);
if i >3600 & i < 3651
testpath=strcat(pathtest,num2str(Testidx),'.mat');
save(testpath,'data');
Testidx=Testidx+1;
continue;
end
trainpath=strcat(pathtrain,num2str(Trainidx),'.mat');
save(trainpath,'data');
Trainidx=Trainidx+1;
  
   
end


