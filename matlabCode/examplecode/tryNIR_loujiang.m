load('C:\Users\LOUJIANG\Documents\GitHub\projectss2020\NIR_Project\NIRTable.mat');
% prepare the modle
load('Example_Data_CaCO3_Kaolin.mat');
%normalization of the data
datawithout = dataKaolin(:,1:224);
datawithout= (datawithout-mean(datawithout,2))./std(datawithout,0,2);
% or map std?
deriv = 1;
datawithout2 = datawithout;
% use the first dirivitive apply to the data
[~,g] = sgolay(5,25);
  for i = 1:size(datawithout,1)    
               datawithout(i,:) = conv(datawithout(i,:)', factorial(deriv) * g(:,deriv+1), 'same');
  end
  deriv =2;
  for i = 1:size(datawithout,1)    
               datawithout2(i,:) = conv(datawithout2(i,:)', factorial(deriv) * g(:,deriv+1), 'same');
  end
  % cut the data window take the range 1350-1500
lowerbound = floor((1350-939)/((1727-939)/223));
upperbound = ceil((1530-939)/((1727-939)/223));
datawithout= datawithout(:,lowerbound:upperbound);
datawithout2= datawithout2(:,lowerbound:upperbound);
% combine data
derivitive1 = [datawithout,dataKaolin(:,225) ];
derivitive2 = [datawithout2,dataKaolin(:,225) ];
derivitive1and2= [datawithout,datawithout2,dataKaolin(:,225) ];

% prepare the NIR data
deriv =1;
testdata = NIRdata(:,1:224);
testdata= (testdata-mean(testdata,2))./std(testdata,0,2);
testdata2 = testdata;
  for i = 1:size(testdata,1)    
               testdata(i,:) = conv(testdata(i,:)', factorial(deriv) * g(:,deriv+1), 'same');
  end

  
  
 yfit = GPRexp.predictFcn(testdata(:,lowerbound:upperbound));

