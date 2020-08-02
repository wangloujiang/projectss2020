%feature selection 
clear all;
clc;
load('data/traindata.mat');
X=traindata(:,1:224);
%Step1: filter
X_filt1=medfilt1(X,3,[],2);
%Step 3: normalization 
X_norm=(X_filt1 - mean(X_filt1,2))./std(X_filt1,0,2);

%Step 4: Data Deveriate 
[~,g] = sgolay(2,11);
 for i = 1:size(X_norm,1)    
               X_d(i,:) = conv(X_norm(i,:)', factorial(2) * g(:,2+1), 'same');
 end
  wavelength = 939:(1727-939)/223:1727;
figure(1)
  Y=1:224;
  plot(Y,X_d);
Y_resp=traindata(:,225);
[idx_1,scores_1] = fscmrmr(X_d,Y_resp);
idx=idx_1(1:2);
featureselection =X_d(:,idx);
mrmr4training=[featureselection, traindata(:,225)];

figure(2)
bar(scores_1(idx_1))
xlabel('Predictor rank');
ylabel('Predictor importance score');
legend('feature selectio with minimum redundancy maximum relevance');
figure(3)
plot(wavelength,scores_1);
xlabel('wavelength/nm');
ylabel('Predictor importance score');
set(gca,'FontSize',20,'Fontname', 'Times New Roman')

save('selectwavelengthnr.mat','idx');
save('mrmr4training.mat','mrmr4training')