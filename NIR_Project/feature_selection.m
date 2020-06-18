%feature selection 
clear all;
clc;
load('NIRTable.mat');
load('NIRdata.mat');
X=NIR;
X=medfilt1(X,3,[],2);
X_norm=(X - mean(X,2))./std(X,0,2)
[~,g] = sgolay(2,11);
  for i = 1:size(X_norm,1)    
               X_filter(i,:) = conv(X_norm(i,:)', factorial(2) * g(:,2+1), 'same');
  end
  figure(1)
  Y=1:224;
  plot(Y,X_filter);
Y_resp=NIRdata(:,225);
[idx_1,scores_1] = fscmrmr(X_filter,Y_resp);
figure(2)
bar(scores_1(idx_1))
xlabel('Predictor rank');
ylabel('Predictor importance score');
legend('feature selectio with minimum redundancy maximum relevance');
%select top 5 wave length 
