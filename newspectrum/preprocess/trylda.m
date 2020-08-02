clear;
clc;

load('traindata');

x = traindata;
[n,m]= size(x);
feature2 = x(:,1:m-1);
result = x(:,m);
%x1=traindata(:,1:224); 
%selcet ROI and offset aufheben
for i = 1:n
    offset=mean(feature2(i,1:10));
    vector(1,1:224)=offset;
    feature2(i,:)=feature2(i,:)-vector;
    feature(i,:)=feature2(i,10:210);
end
%1.Derivate 
%derivate=1;
%order=3;
%window=11;
%[~,g] = sgolay(order,window);
%for i = 1:size(feature,1)    
 %              feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
  %  end
%standardlization according to each colum 
meanvaluelda=mean(feature);
stdvaluelda=std(feature);
feature= (feature-meanvaluelda)./stdvaluelda;

%preprocess 
%feature=medfilt1(feature,3,[],2);

%feature=normalize(feature);


% get distinct class
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
numComp = input('Select number of Components: ');

v_lda=V(:,1:numComp);
feature=feature*v_lda;
NIRldareduced= [feature,result];
save('lda4training.mat','NIRldareduced');
save('ldavector.mat','v_lda');
save('meanvaluelda.mat','meanvaluelda')
save('stdvaluelda.mat','stdvaluelda');