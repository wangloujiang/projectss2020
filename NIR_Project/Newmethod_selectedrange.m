%correct Kaolin content caculation 
clear all;
clc;
load('E:\ARP\work\NIR_Project\NIR coefficient\Kaolin_PLS_Comp_2_deriv1and2_1350');
load('NIRTable');
wavelength = 939:(1727-939)/223:1727;
%pre-process
X=NIRdata(:,1:224);
%Step1: filter
X=medfilt1(X,3,[],2);

%Step 3: normalization 
X_norm=(X- mean(X,2))./std(X,0,2);
%Step 4: Derivative 
 [~,g] = sgolay(2,9);
 deriv1=1;
  for i = 1:size(X_norm,1)    
               X_deriv1(i,:) = conv(X_norm(i,:)', factorial(deriv1) * g(:,deriv1+1), 'same');
  end
 deriv2=2;
    for i = 1:size(X_norm,1)    
               X_deriv2(i,:) = conv(X_norm(i,:)', factorial(deriv2) * g(:,deriv2+1), 'same');
    end

  
datamin = 1350;
datamax=1500;
idx = (wavelength > datamin) & (wavelength < datamax);
wavelength = wavelength(idx);
X_selected1 =  X_deriv1(:,idx);
X_selected2 =  X_deriv2(:,idx);
X_selected = [X_selected1,X_selected2];

 %Content Caculation:
 [n,p] = size(X_selected);
 Y_fit=[ones(n,1) X_selected]*beta
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
