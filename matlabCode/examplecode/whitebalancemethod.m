
%% method 1, Gray world
RGB= data(1).camW;
R = RGB(:,:,1);      G = RGB(:,:,2);      B = RGB(:,:,3);
Rx4 = RGB(:,:,1)*4;  Gx4 = RGB(:,:,2)*4;  Bx4 = RGB(:,:,3)*4; 
 
Rave = mean(mean(R)); 
Gave = mean(mean(G)); 
Bave = mean(mean(B));
Kave = (Rave + Gave + Bave) / 3;
 
R1 = (Kave/Rave)*R; G1 = (Kave/Gave)*G; B1 = (Kave/Bave)*B; 
R2 = (Kave/Rave)*Rx4; G2 = (Kave/Gave)*Gx4; B2 = (Kave/Bave)*Bx4; 
 
RGB_white = cat(3, R1, G1, B1);
RGB_whitex4 = cat(3, R2, G2, B2);
 
RGB_white_out = uint8(RGB_white); RGB_white_outx4 = uint8(RGB_whitex4);
imshowpair(RGB,RGB_white_out,"montage")
%% method 2 , manual change the background color
object= ImageDataAnalyzer;
object.imgRGB=  data(1).camW;
object.imgUV= data(1).camWUV
object.whiteBalance();
imshowpair(object.imgRGB,RGB_white_out,"montage")
figure
imshowpair(RGB,RGB_white_out,"montage")





            
            