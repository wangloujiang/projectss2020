%% preparation for Transferlerning
% split the total 4000 object into Training part, Validation part and Test
% part 
% the ratio is 60%:20%:20% 
% before run this code, the size of the image should be corrected according
% to requirement of pre trained network 
%% code 
%insert the path of resized 4000 dataset
imds = imageDatastore('D:\Master_Maschinenbau\ARP\work\Final\Transferlearning\227x227',...
    'IncludeSubfolders',true, ...
    'LabelSource','foldernames');
%reserve the Testdata
[imdsTandV,imdsTest] = splitEachLabel(imds,0.8,'randomized');
%split the Trainning and Validation data
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.75,'randomized');
%save the 3 kinds of data automatically, the store path is shown bellow:
save('D:\Master_Maschinenbau\ARP\work\Final\Transferlearning\Dataset\227Train.mat','imdsTrain'); 
save('D:\Master_Maschinenbau\ARP\work\Final\Transferlearning\Dataset\227Validation.mat','imdsValidation'); 
save('D:\Master_Maschinenbau\ARP\work\Final\Transferlearning\Dataset\227Test.mat','imdsTest'); 