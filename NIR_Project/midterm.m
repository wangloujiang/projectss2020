clear;
clc; 
wavelength = 939:(1727-939)/223:1727;
load('NIRTable');
X=NIRdata(:,1:224);
figure(1)
hold on;
p1=plot(wavelength, X(451:471,:),'r');
p2=plot(wavelength, X(2383:2403,:),'b');
legend([p1(1) p2(1)],{'class 2 ','class 7'})
xlabel('wavelength/nm')
ylabel('Refleciton')
set(gca,'FontSize',20,'Fontname', 'Times New Roman')