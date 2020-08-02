clear;
clc
load('traindata.mat');

X=traindata(:,1:224);
label=traindata(:,225);
[n,m]=size(X);
%select ROI 
X=X(:,10:210);
%standarlization according to each row 
X=zscore(X,0,2);
order=3;
window=11;
derivate=1;
[~,g] = sgolay(order,window);
for i = 1:size(X,1)    
               X(i,:) = conv(X(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
end
%standardlization according to each colum 
meanvalue=mean(X);
stdvalue=std(X);
X=(X-meanvalue)./stdvalue;

%convariance 
X_std=mapstd(X);
X_cov=cov(X_std);
[V,D]=eig(X_cov);
%Evaluation:
[a,b]= size(D);
Aufsum=sum(D,'all');
sumV=[];
ratio=[];
add=0;

for i=0:a-1
EV=D(a-i,b-i);
add=add+EV;
sumV(i+1)=add;
ratio(i+1)=sumV(i+1)/Aufsum;
end
figure(1)
plot(1:a,ratio,'b-o')
xlabel('number of Eigenvalue');
ylabel('Percentage of main Component');
% wait for selection of main component: 
numComppca = input('Select number of Components for pca: ');

v_combpca=V(:,b+1-numComppca:b);
X_selectcomb=X*v_combpca;
NIR_featurenew=[X_selectcomb,label];
save('combpcavector.mat','v_combpca');

x = NIR_featurenew;
[nl,ml]= size(x);
feature = x(:,1:ml-1);
result = x(:,ml);
class = unique(result);
classnumber = length(class);
overallmean = mean(feature);
sw = zeros(1,1);
sb = zeros(1,1);
% do the process for each class
for i = 1:classnumber
featurethisid = find(result == class(i));
dataset = feature(featurethisid,:);
meanthis = mean(dataset);
dataset = dataset - repmat(meanthis, length(featurethisid),1);
% between features
sw = sw + dataset'*dataset;
% in features
sb = sb + length(featurethisid)*(meanthis-overallmean)'*(meanthis-overallmean);
end
% get the matrix
matrix = inv(sw)*sb;
% do the analysis
e =  eig(matrix);
[V,D] = eig(matrix);
%Evaluation:
[a,b]= size(D);
Aufsum=sum(D,'all');
sumV=[];
ratio=[];
add=0;

for i=1:a
EV=abs(D(i,i));
add=add+EV;
sumV(i)=add;
ratio(i)=sumV(i)/Aufsum;
end
figure(1)
plot(1:a,ratio,'b-o')
xlabel('number of Eigenvalue');
ylabel('Percentage of main Component');
% wait for selection of main component: 
numComplda = input('Select number of Components: ');

v_comblda=V(:,1:numComplda);
feature=feature*v_comblda;
NIRcombreduced= [feature,result];

save('combldavector.mat','v_comblda');
save('comb4training.mat','NIRcombreduced');

