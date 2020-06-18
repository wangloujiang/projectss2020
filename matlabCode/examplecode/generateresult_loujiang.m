%% this automaticall label the data and delet all the 404 result, only 1 and 2 are used.
% define the container
featuresnew = zeros(200,24);
resultsnew = zeros(1,25);
%% define the pass to the file（stupid matlab）
class1= [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresDurchgefarbt1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresDurchgefarbt2.mat')];

class2 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresgKarton1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresgKarton2_less.mat')];

class3 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresgPapier1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresgPapier2.mat')];

class4 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresMagazine1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresMagazine2.mat')];

class5 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresWellpappe1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresWellpappe2.mat')];

class6 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresWerbehefte1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresWerbehefte1.mat')];

class7 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featureswKarton1_less.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featureswKarton2_less.mat')];

class8 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featureswPapier1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featureswPapier2.mat')];

class9 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featureswWellpappe1.mat')];

class10 = [string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresZeitungen1.mat'),...
    string('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\matlabCode\examplecode\newdata\featuresZeitungen1.mat')];

%% combine and label the data together
for classnumber = 1:10
    file=strcat('class',num2str(classnumber));
    [n m]=size(eval(file));
    for  instance = 1:m
        a= eval(file);
        load(a(instance));
        % get rid of the wrong data
        idNoweight = featuresnew(:,1)== 404;
        featuresnew(idNoweight,:) =[];
        idNoresult = sum(featuresnew,2)== 0;
        featuresnew(idNoresult,:) =[];
        [length width]= size(featuresnew);
        label = ones(length,1).*classnumber;
        featuresnew = [featuresnew,label];
        
        if sum(resultsnew)==0
            resultsnew = featuresnew;
            
        else
            resultsnew = [resultsnew;featuresnew];
        end
        
        
        
        
    end
    
end
%% random the data for the input 
random = randperm(size(resultsnew,1));
resultsnew = resultsnew(random,:);