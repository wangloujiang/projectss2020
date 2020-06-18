%% here test the generated model with the data.
% load the features
load('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\svm_trainedmodel.mat');
load('featuresloujiang.mat');

% load the test set
load('features10KlassenNeueAlgorithmen.mat')
resultreal = results(:,21);

%% change the note of the class to new database

id1 = resultreal(:,1)==1;% Zeitung in new database as 10
id2 = resultreal(:,1)==2;% Magazine in new databse as 4

id5 = resultreal(:,1)==5;% wpaper in new database as 8
id6 = resultreal(:,1)==6; % gpaper in new database as 3

id8 = resultreal(:,1)==8;% bWellpappen in new database as 5
id9 = resultreal(:,1)==9;% wWellpappen in new database as 9
id10 = resultreal(:,1)==10;% gkarton in new database as 2

% change the result class
resultreal(id1,1)=10;
resultreal(id2,1)=4;
resultreal(id5,1)=8;
resultreal(id6,1)=3;
resultreal(id8,1)=5;
resultreal(id9,1)=9;
resultreal(id10,1)=2;


id3 = resultreal(:,1)==3;% don not know,delet
resultreal(id3,:)=[];
featuresnew(id3,:)=[];
id4 = resultreal(:,1)==4;% don not know,delet
resultreal(id4,:)=[];
featuresnew(id4,:)=[];
id7 = resultreal(:,1)==7; % don not know,delet
resultreal(id7,:)=[];
featuresnew(id7,:)=[];
id12 = resultreal(:,1)==12;% don not know,delet
resultreal(id12,:)=[];
featuresnew(id12,:)=[];
id15 = resultreal(:,1)==15;% don not know,delet
resultreal(id15,:)=[];
featuresnew(id15,:)=[];
% fit the resultlength






%% do the calculation 
% into the modle to get the result
resultfit = trainedModel.predictFcn(featuresnew);
difference = resultfit -resultreal;
id= difference(:,1)==0;
sum(id)
