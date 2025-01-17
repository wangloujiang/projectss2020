clear all;
clc;
load ('Example_Data_CaCO3_Kaolin.mat');
spectra = dataKaolin;
% sort the Data according to response 
data_sort= sortrows(spectra,225);
data_load= data_sort(:,1:224);
data_response=data_sort(:,225);
wavelength = 939:(1727-939)/223:1727;
%pre-process 
%Step1: filter
data_filt1=medfilt1(data_load,3,[],2);
%Step 2: Savitzky-Golay filter
order=2;
framelen=11;
b = sgolay(order,framelen);
  for i = 1:size(data_filt1,1)
      x=data_filt1(i,:);
      x_t=x';
      ycenter = conv(x_t,b((framelen+1)/2,:),'valid');
      ybegin = b(end:-1:(framelen+3)/2,:) * x_t(framelen:-1:1);
      yend = b((framelen-1)/2:-1:1,:) * x_t(end:-1:end-(framelen-1));
      y = [ybegin; ycenter; yend];
      data_filt2(i,:)=y;
      
               %data_filt2(i,:) = conv(data_filt1(i,:)', factorial(0) * g(:,0+1), 'same');
  end
%Step 3: normalization 
data_norm=(data_filt2 - mean(data_filt2,2))./std(data_filt2,0,2);

%Step 4: Data Deveriate 
[~,g] = sgolay(2,11);
 for i = 1:size(data_norm,1)    
               data_d(i,:) = conv(data_norm(i,:)', factorial(2) * g(:,2+1), 'same');
  end

 %Step 4: Split Data
 data_load_cal= data_d;
 data_load_cal(1:3:end,:)=[];
 data_load_val=data_d(1:3:end,:);
 
 data_response_cal=data_response;
 data_response_cal(1:3:end,:)=[];
 data_response_val=data_response(1:3:end,:);
 %Step 5: Regression: 主成分分析和偏线性回归
 %Step 5.1 选取成分数 ncomp assumption: n=10
 [n,p] = size(data_load_cal);
 [Xl,Yl,Xs,Ys,beta,pctVar,PLSmsep] = plsregress(data_load_cal, data_response_cal,10,'CV',10);
 PCRmsep = sum(crossval(@pcrsse,data_load_cal, data_response_cal,'KFold',5),1) / n; 
 figure(1)
 plot(1:10,cumsum(100*pctVar(2,:)),'b-o'); 
 xlabel('Number of components');
 ylabel('Percent Variance Explained in Y');
 figure (2) 
 plot(0:10,PLSmsep(2,:),'b-o',0:10,PCRmsep,'r-^');
 xlabel('Number of components');
 ylabel('Estimated Mean Squared Prediction Error');
 legend({'PLSR' 'PCR'},'location','NE')
 numComp = input('Select number of Components: ');
 %Step 5.2 Regression assumption: n=5
 [Xl,Yl,Xs,Ys,beta,pctVar,PLSmsep] = plsregress(data_load_cal, data_response_cal,numComp,'CV',10);
 yfitPLS=[ones(n,1) data_load_cal]*beta;
 %pca 
 [PCALoadings,PCAScores,PCAVar] = pca(data_load_cal,'Economy',false);
 betaPCR = regress(data_response_cal-mean(data_response_cal), PCAScores(:,1:numComp)); % calculate the coefficient
 betaPCR = PCALoadings(:,1:numComp)*betaPCR;
 betaPCR = [mean(data_response_cal) - mean(data_load_cal)*betaPCR; betaPCR];
 yfitPCR = [ones(n,1) data_load_cal]*betaPCR;
 PCRmsep = sum(crossval(@pcrsse,data_load_cal, data_response_cal,'KFold',10),1) / n;

 %Step 5.3 Result
 z = round(min(data_response_cal,[],'all')): round(max(data_response_cal,[],'all'));
 figure(3)
 plot(data_response_cal,yfitPLS, 'bo', data_response_cal,yfitPCR,'r*',z,z,'k--');
 %Step 5.4 Caculate RMSE and Regression ratio
 TSS = sum((data_response_cal-mean(data_response_cal)).^2);
 RSS_PLS = sum((data_response_cal-yfitPLS).^2);
 rsquaredPLS = 1 - RSS_PLS/TSS;
 %PCA
 RSS_PCR = sum((data_response_cal-yfitPCR).^2);
 rsquaredPCR = 1 - RSS_PCR/TSS;
 sprintf("The regression ration of PLS is: ",'%.f',rsquaredPLS, "The regression Ration of PCA is: ",'%.f',rsquaredPCR);
 %Step 6 Validation 
 yfitPLS_V=[ones(n,1) data_load_val]*beta;
 yfitPCA_V=[ones(n,1) data_load_val]*betaPCR;
 %Step 6.1 show the result 
 z = round(min(data_response_val,[],'all')): round(max(data_response_val,[],'all'));
 figure(4)
 plot(data_response_val,yfitPLS, 'bo', data_response_val,yfitPCR,'r*',z,z,'k--');
 title('Model-Validation');
 xlabel('Observed Response');
 ylabel('Fitted Response');
 
 

 