%feature selection 
clear all;
clc;
load('E:\ARP\work\NIR_Project\feature extraction\selectdata.mat');
load('E:\ARP\work\NIR_Project\feature extraction\idx');
X=testdata(:,1:224);
%Step1: filter
X_filt1=medfilt1(X,3,[],2);
%Step 2: Savitzky-Golay filter
order=2;
framelen=11;
b = sgolay(order,framelen);
  for i = 1:size(X_filt1,1)
      x=X_filt1(i,:);
      x_t=x';
      ycenter = conv(x_t,b((framelen+1)/2,:),'valid');
      ybegin = b(end:-1:(framelen+3)/2,:) * x_t(framelen:-1:1);
      yend = b((framelen-1)/2:-1:1,:) * x_t(end:-1:end-(framelen-1));
      y = [ybegin; ycenter; yend];
      X_filt2(i,:)=y;
      
               %data_filt2(i,:) = conv(data_filt1(i,:)', factorial(0) * g(:,0+1), 'same');
  end
%Step 3: normalization 
X_norm=(X_filt2 - mean(X_filt2,2))./std(X_filt2,0,2);

%Step 4: Data Deveriate 
[~,g] = sgolay(2,11);
 for i = 1:size(X_norm,1)    
               X_d(i,:) = conv(X_norm(i,:)', factorial(2) * g(:,2+1), 'same');
  end
idx=idx_1(1,1:6);
wavelength=X_d(:,idx);

