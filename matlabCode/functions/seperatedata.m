
function [traindata,testdata] = seperatedata(inputmatrix,percentoftest)
%% Seperate the Data into test and train
%   input:
%   the labeled data  the percentage of the train data. 
%   return: 
%   the seperated matrix of data with two matrix in sequence
%   traindata,testdata            
%   example:[traindata,testdata] = seperatedata(inputmatrix,percentoftest)
%% Preprocess
newid = zeros(1,1); %initial the storage area
[n m]= size(inputmatrix); %get the size of the input matrix to get the last column
classids = unique(inputmatrix(:,m)); % get the ids for the different class label.
%% Devided with the selected ids to each class
for class = 1:max(classids)
    id = inputmatrix(:,m)== class; % get all the position of the object in this class
    number = 1:size(inputmatrix,1);
    id = id .* number'; % make the logic 0 1 matrix to the index matrix
    iszero= id(:,1) == 0;
    id(iszero,:)=[]; % delet the 0 in the matrix to compact.
    random = randperm(size(id,1)); % make a randem index of the ids(index)selected
    % combine the id to the total selected out ids
    if(sum(id)==0)
        newid = id(random(1:floor((1-percentoftest)*size(id,1))));
    else
        newid = [newid;id(random(1:floor((1-percentoftest)*size(id,1))))]; 
    end
end
%% post process to output the matrix with selected ids
[n m]= size(newid);
traindata = inputmatrix(newid(2:n),:); % get all the usefull ids as index to generate the traindata
random = randperm(size(traindata,1));
traindata = traindata(random,:);% random the traindata sequence

testdata = setdiff(inputmatrix,traindata,'row');% all the rest unique objects are testdata


end

