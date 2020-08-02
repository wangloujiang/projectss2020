clear;
clc;
load('Example_Data_CaCO3_Kaolin');
x=dataKaolin;
wave=939:(1727-939)/223:1727; 
figure(1)
plot(wave, x(36,1:224));
title('NIR Spectrum');
xlabel('wavelength/nm');
ylabel('Reflection');
