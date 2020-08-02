clear;
clc;
load('testdata2.mat');
load('meanvalue.mat');
load('stdvalue.mat');
load('sae.mat')
feature=testdata2(:,1:224);
label=testdata2(:,225);
[n,m]=size(feature);
responsenew=[];
for i=1:n

    num=label(i);
    new(1,1:10)=0;
    new(1,num)=1;
    responsenew=[responsenew;new];

end
label=responsenew';
%select ROI 
feature=feature(:,10:210);
%standarlization according to each row 
feature=zscore(feature,0,2);
order=3;
window=11;
derivate=1;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
end
feature=(feature-meanvalue)./stdvalue;
feature=feature';
y = nirnet(feature);
plotconfusion(label,y);