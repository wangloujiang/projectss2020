load('traindata.mat');
x=traindata(:,1:224); 
meanvalue=mean(x);
stdvalue=std(x);