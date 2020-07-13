
function [traindata,testdata] = seperatedata(inputmatrix,percentoftest)
%% Seperate the Data into test and train
%   input:
%   the labeled data  the percentage of the train data. 
%   return: 
%   the seperated matrix of data with two matrix in sequence
%   traindata,testdata            
%   example:[traindata,testdata] = seperatedata(inputmatrix,percentoftest)
%% Code
newid = zeros(1,1);
%resultsnew = NIRdata;
[n m]= size(inputmatrix);
classids = unique(inputmatrix(:,m));

for class = 1:max(classids)
    id = inputmatrix(:,m)== class;
    number = 1:size(inputmatrix,1);
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
[n m]= size(newid);
traindata = inputmatrix(newid(2:n),:);
random = randperm(size(traindata,1));
traindata = traindata(random,:);

testdata = setdiff(inputmatrix,traindata,'row');


end

