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
%Step1: filter
%X=medfilt1(X,3,[],2);

%for i = 1:n
%    offset=mean(X2(i,1:5));
%    vector(1,1:224)=offset;
%    X2(i,:)=X2(i,:)-vector;
%    X(i,:)=X2(i,6:224);
%end

 %[~,g] = sgolay(2,11);
 %for i = 1:size(X,1)    
  %            X(i,:) = conv(X(i,:)', factorial(1) * g(:,1+1), 'same');
 %end

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
numComp = input('Select number of Components: ');

V_select=V(:,b+1-numComp:b);
X_select=X*V_select;
NIR_featurenew=[X_select,label];
save('pca4training.mat','NIR_featurenew');
save('pcavector.mat','V_select');

