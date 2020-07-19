function [firstorder,secondorder,firstoderwithlabel,secondorderwithlabel] = NIRprepossing(inputmatrix,lowerwavelength,higherwavelength)
%% NIRPREPOSSING 
% Preproceessing of the NIR data, input the NIR average data, and wanted
% wavelength area, output the derivitative first order and second order.
% input:
% inputmatrix,lowerwavelength,higherwavelength
% output:
% cutted first and second order derivitive matrix with and without label.
% exampel:
% [firstorder,secondorder,firstoderwithlabel,secondorderwithlabel]
% =NIRprepossing(NIRdata,1300,1400);

%% Constant defintion
lowmin = 939;
highmax = 1727;
withlable= true; 

%% Preprocessing
% check the lower and higherwavelength, make sure low is lower than high
changestorage= lowerwavelength;
if(lowerwavelength>higherwavelength)
    lowerwavelength = higherwavelength;
    higherwavelength = changestorage;
end

% check the lower is bigger than the smallest wavelength
if(lowerwavelength < lowmin)
lowerwavelength = lowmin;
end

% check the upper is bigger than the biggest wavelength
if(higherwavelength > highmax)
higherwavelength = highmax;
end

% check the input matrix with or without the label.
[n m]= size(inputmatrix); %n*m matrix
if(m == 224 || m ==225 )
if(m ==224)
    withlable = false;
end
else
    error("the inputmatrix is illeagle");
end
%% Processing of the data
%normalization of the data
datawithout = inputmatrix(:,1:224);
datawithout= (datawithout-mean(datawithout,2))./std(datawithout,0,2); % rowweis standard get
% take the first derivitive 
deriv = 1; % define the order
datawithout2 = datawithout;% save the matrix for the second derevitive 
% use the first dirivitive apply to the data
[~,g] = sgolay(2,3); % seleted sgo filter length and window.(bigger smoother, but lost the small tips.)
% take derivitive
  for i = 1:size(datawithout,1)    
               datawithout(i,:) = conv(datawithout(i,:)', factorial(deriv) * g(:,deriv+1), 'same');
  end
% take the second order dirivitive of the data
  deriv =2;
  for i = 1:size(datawithout,1)    
               datawithout2(i,:) = conv(datawithout2(i,:)', factorial(deriv) * g(:,deriv+1), 'same');
  end
  
%% cut the data window 
lowerbound = floor((lowerwavelength-939)/((highmax-lowmin)/223));
upperbound = ceil((higherwavelength-939)/((highmax-lowmin)/223));
if(lowerbound == 0)
    lowerbound =1;
end
% out put the data 
firstorder= datawithout(:,lowerbound:upperbound);
secondorder= datawithout2(:,lowerbound:upperbound);
if(withlable)
    firstoderwithlabel = [firstorder,inputmatrix(:,225)];
    secondorderwithlabel =[secondorder,inputmatrix(:,225)];
else
    firstoderwithlabel =[];
    secondorderwithlabel= [];
end


end



