function comb2plslda (traindata)

feature=traindata(:,1:224);
response=traindata(:,225);
responsenew=[];
[n,m]=size(feature);
%get response matrix
for i=1:n 
    num=response(i);
    new(1,1:10)=0;
    new(1,num)=1;
    responsenew=[responsenew;new];
end
    
%response=diag(response);

%select ROI 
feature=feature(:,10:210);
%standarlization according to each row 
feature=zscore(feature,0,2);
%1.Derivate 
derivate=1;
order=3;
window=11;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
    end
%standardlization according to each colum 
meanvalue=mean(feature);
stdvalue=std(feature);
feature= (feature-meanvalue)./stdvalue;


%for i = 1:n
 %   offset=mean(feature2(i,1:5));
  %  vector(1,1:224)=offset;
   % feature2(i,:)=feature2(i,:)-vector;
    %feature(i,:)=feature2(i,6:224);
%end
%select amount of main component of pls: 
 [~,~,~,~,~,pctVar,~] = plsregress(feature,responsenew,10,'CV',10);
 figure(1)
 plot(1:10,cumsum(100*pctVar(2,:)),'b-o'); 
 xlabel('Number of components');
 ylabel('Percent Variance Explained in Y');
 numComppls = input('Select number of Components for pls: ');
%feature=normalize(feature);
[Xloadings,Yloadings,Xscores,Yscores,betaPLS10,PLSPctVar,~,v_comb2pls] = plsregress(feature,responsenew,numComppls);
featurereduced=Xscores;
feature4pls= [featurereduced,response];

save('comb2plsvector.mat','v_comb2pls');

x =feature4pls;
[nl,ml]= size(x);
feature2 = x(:,1:ml-1);
result = x(:,ml);
class = unique(result);
classnumber = length(class);
overallmean = mean(feature2);
sw = zeros(1,1);
sb = zeros(1,1);
% do the process for each class
for i = 1:classnumber
featurethisid = find(result == class(i));
dataset = feature2(featurethisid,:);
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
numComplda = input('Select number of Components for lda: ');

v_comb2lda=V(:,1:numComplda);
feature2=feature2*v_comb2lda;
NIRcomb2reduced= [feature2,result];

save('comb2ldavector.mat','v_comb2lda');
save('comb24training.mat','NIRcomb2reduced');
fprintf('------feature extraction complete------\n');
end






