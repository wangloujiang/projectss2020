%correct Kaolin content caculation 
clear all;
clc;
load('E:\ARP\work\NIR_Project\NIR coefficient\Kaolin_PLS_Comp_4');
load('NIRTable');
%pre-process
X=NIRdata(:,1:224);
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
%Step 4: Derivative 
[~,g] = sgolay(2,11);
  for i = 1:size(X_norm,1)    
               X_d(i,:) = conv(X_norm(i,:)', factorial(2) * g(:,2+1), 'same');
  end


 %Content Caculation:
 [n,p] = size(X_d);
 Y_fit=[ones(n,1) X_d]*beta
 %mean value 
 Y_mean_1=mean(Y_fit(1:400));
 Y_mean_2=mean(Y_fit(401:782));
 Y_mean_3=mean(Y_fit(783:1182));
 Y_mean_4=mean(Y_fit(1183:1582));
 Y_mean_5=mean(Y_fit(1583:1982));
 Y_mean_6=mean(Y_fit(1983:2382));
 Y_mean_7=mean(Y_fit(2383:2674));
 Y_mean_8=mean(Y_fit(2675:3074));
 Y_mean_9=mean(Y_fit(3075:3274));
 Y_mean_10=mean(Y_fit(3275:3674));
 
 Y_mean=[Y_mean_1,Y_mean_2,Y_mean_3,Y_mean_4,Y_mean_5,Y_mean_6,Y_mean_7,Y_mean_8,Y_mean_9,Y_mean_10];
 
 %show the result: 
Y=NIRdata(:,225);
y1=[0,0]; y2=[0,10];
figure(2);
hold on;
scatter(Y_fit(1:400,1),Y(1:400,1),'filled');
scatter(Y_fit(401:782,1),Y(401:782,1),'filled');
scatter(Y_fit(783:1182,1),Y(783:1182,1),'filled');
scatter(Y_fit(1183:1582,1),Y(1183:1582,1),'filled');
scatter(Y_fit(1583:1982,1),Y(1583:1982,1),'filled');
scatter(Y_fit(1983:2382,1),Y(1983:2382,1),'filled');
scatter(Y_fit(2383:2674,1),Y(2383:2674,1),'filled');
scatter(Y_fit(2675:3074,1),Y(2675:3074,1),'filled');
scatter(Y_fit(3075:3274,1),Y(3075:3274,1),'filled');
scatter(Y_fit(3275:3674,1),Y(3275:3674,1),'filled');
scatter(Y_mean,1:10,'x','r','LineWidth',2);
plot(y1,y2,'k--');
legend('durchgefabrt','gKarton','gPaper','Magazine','Wellpappe','Werbehefte','wKarton','wPapier','wWellpappe','Zeitung');
hold off;
