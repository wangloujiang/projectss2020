%PLS feature extraction 
load('traindata');
feature2=traindata(:,1:224);
response=traindata(:,225);
responsenew=[];
[n,m]=size(feature2);
for i=1:n 
    num=response(i);
    new(1,1:10)=0;
    new(1,num)=1;
    responsenew=[responsenew;new];
end
    
%response=diag(response);

for i = 1:n
    offset=mean(feature2(i,1:5));
    vector(1,1:224)=offset;
    feature2(i,:)=feature2(i,:)-vector;
    feature(i,:)=feature2(i,6:224);
end
feature=normalize(feature);
[Xloadings,Yloadings,Xscores,Yscores,betaPLS10,PLSPctVar] = plsregress(feature,responsenew,10);
featurereduced=feature*Xloadings;
traindataset= [featurereduced,response];