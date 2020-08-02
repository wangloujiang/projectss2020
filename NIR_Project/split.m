%ML
%Split Data 
load('NIRTable.mat');
X=NIRdata;
percentoftest = 0.3;% define how much are taken out as independent test data
newid = zeros(1,1);
for class = 1:10
    id = X(:,225)== class;
    number = 1:size(X,1);
    id = id .* number';
    iszero= id(:,1) == 0;
    id(iszero,:)=[];
    random = randperm(size(id,1));
    if(sum(id)==0)
        newid = id(random(1:floor((1-percentoftest)*size(id,1))));
    else
        newid = [newid;id(random(1:floor((1-percentoftest)*size(id,1))))];
    end
end
traindata = X(newid(2:2443),:);
random = randperm(size(traindata,1));
traindata = traindata(random,:);

testdata = setdiff(X,traindata,'row');