clear all;
clc
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
%Step 2: normalization 
data_norm=(data_filt1 - mean(data_filt1,2))./std(data_filt1,0,2);
%Step 3: Savitzky-Golay filter
 [~,g] = sgolay(2,9);
 deriv1=1;
  for i = 1:size(data_norm,1)    
               data_deriv1(i,:) = conv(data_norm(i,:)', factorial(deriv1) * g(:,deriv1+1), 'same');
  end
 deriv2=2;
    for i = 1:size(data_norm,1)    
               data_deriv2(i,:) = conv(data_norm(i,:)', factorial(deriv2) * g(:,deriv2+1), 'same');
    end
%Step 4 Select the Range 
datamin = 1350;
datamax=1500;
idx = (wavelength > datamin) & (wavelength < datamax);
wavelength = wavelength(idx);
data_selected1 =  data_deriv1(:,idx);
data_selected2 =  data_deriv2(:,idx);
%combine the data 
data_deriv = [data_selected1,data_selected2];
 %Step 4: Split Data
 data_load_cal= data_deriv;
 data_load_cal(1:3:end,:)=[];
 data_load_val=data_deriv(1:3:end,:);
 
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
 [n,p] = size(data_load_val);
 yfitPLS_V=[ones(n,1) data_load_val]*beta;
 yfitPCA_V=[ones(n,1) data_load_val]*betaPCR;
 %Step 6.1 show the result 
 z = round(min(data_response_val,[],'all')): round(max(data_response_val,[],'all'));
 figure(4)
 plot(data_response_val,yfitPLS_V, 'bo', data_response_val,yfitPCA_V,'r*',z,z,'k--');
 title('Model-Validation');
 xlabel('Observed Response');
 ylabel('Fitted Response');
 figure(5)
 hold on;
 a=1:24;
 scatter(a,data_response_val,'r*');
 scatter(a,yfitPLS_V,'bo');
 %Calculation: 
  RMSE_PSL_P = sqrt(mean((data_response_val - yfitPLS_V).^2));
  RMSE_PCR_P = sqrt(mean((data_response_val - yfitPCA_V).^2));
 
 

 