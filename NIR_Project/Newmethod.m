%correct Kaolin content caculation 
clear all;
clc;
load('E:\ARP\work\NIR_Project\NIR coefficient\Kaolin_PLS_Comp_6');
load('NIRdata');
%pre-process
X=NIR;
%Step1: filter
X=medfilt1(X,3,[],2);
%Step 2: Savitzky-Golay filter
order=2;
framelen=11;
b = sgolay(order,framelen);
  for i = 1:size(X,1)
      x_filt=X(i,:);
      x_t=x_filt';
      ycenter = conv(x_t,b((framelen+1)/2,:),'valid');
      ybegin = b(end:-1:(framelen+3)/2,:) * x_t(framelen:-1:1);
      yend = b((framelen-1)/2:-1:1,:) * x_t(end:-1:end-(framelen-1));
      y = [ybegin; ycenter; yend];
      X_filter(i,:)=y;
      
               %data_filt2(i,:) = conv(data_filt1(i,:)', factorial(0) * g(:,0+1), 'same');
  end
%Step 3: normalization 
X_norm=(X_filter - mean(X_filter,2))./std(X_filter,0,2);


 %Content Caculation:
 [n,p] = size(X_norm);
 Y_fit=[ones(n,1) X_norm]*beta
 %show the result: 
y1 = ones (200,1);
y2 = ones(200,1).*2;
y3 = ones(400,1).*3;
y4 = ones(200,1).*4;
y5 = ones(400,1).*5;
y6 = ones(400,1).*6;
y7 = ones(400,1).*7;
y = [y1;y2;y3;y4;y5;y6;y7];
figure(2);
hold on;
scatter(Y_fit(1:200,1),y1,'filled');
scatter(Y_fit(201:400,1),y2,'filled');
scatter(Y_fit(601:1000,1),y3,'filled');
scatter(Y_fit(1001:1200,1),y4,'filled');
scatter(Y_fit(1201:1600,1),y5,'filled');
scatter(Y_fit(1601:2000,1),y6,'filled');
scatter(Y_fit(2001:2400,1),y7,'filled');
hold off;
