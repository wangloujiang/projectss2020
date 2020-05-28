%% quick check of the method imbinary
img = imread("D:\Pictures\Pictures\5783_1.jpg");
roi = [60 2585 70 2100];

img = img(roi(3):roi(4),roi(1):roi(2),:);
mask = zeros(2134,2704);
mask(roi(1):(roi(1)+roi(3)),roi(2):(roi(2)+roi(4))) = 1;

Rx4 = img(:,:,1)*4;  Gx4 = img(:,:,2)*4;  Bx4 = img(:,:,3)*4; 
R = img(:,:,1);      G = img(:,:,2);      B = img(:,:,3);
Rave = mean(mean(R)); 
Gave = mean(mean(G)); 
Bave = mean(mean(B));
Kave = (Rave + Gave + Bave) / 3;
R1 = (Kave/Rave)*R; G1 = (Kave/Gave)*G; B1 = (Kave/Bave)*B; 
R2 = (Kave/Rave)*Rx4; G2 = (Kave/Gave)*Gx4; B2 = (Kave/Bave)*Bx4; 
RGB_white = cat(3, R1, G1, B1);
RGB_whitex4 = cat(3, R2, G2, B2);

img2=imgaussfilt(RGB_whitex4,1);

imgray = rgb2gray(img2);
J = imnoise(imgray,"salt & pepper",0.1);
K = medfilt2(J);
I_bw = imbinarize(K,'adaptive','ForegroundPolarity','dark');




s = strel('disk',10);% define the brush
I_close = imclose(I_bw,s); % fill the small clapse
imshow(I_close)
subplot(1,2,1);imshow(img);title('result iamge');subplot(1,2,2), imshow(I_close);title('the edge ');

%% detect the edge 
[height,width,a] = size(I_close);
filter1 = ones(height,width);
filtedImg = img;
for heightsearch =  1:height
detectBlack = false;
detectWhite = false;
imgleft=1;
    for widesearch = 1:width
        if I_close(heightsearch,widesearch) == false  
           detectBlack = true;
        end
        if (I_close(heightsearch,widesearch) == true) && (detectBlack == true )
           imgleft = widesearch;
           break;
        end
    end
     filtedImg(heightsearch,1:imgleft,1)=255;
     filtedImg(heightsearch,1:imgleft,2)=255;
     filtedImg(heightsearch,1:imgleft,3)=255;
     filter1(heightsearch,1:imgleft)=0;
        

end
for heightsearch =  1:height
detectBlack = false;
detectWhite = false;
imgright=1;
    for widesearch = width:-1:1
        if I_close(heightsearch,widesearch) == false  
           detectBlack = true;
        end
        if (I_close(heightsearch,widesearch) == true) && (detectBlack == true )
           imgright = widesearch;
           break;
        end
    end
     filtedImg(heightsearch,imgright:width,1)=255;
     filtedImg(heightsearch,imgright:width,2)=255;
     filtedImg(heightsearch,imgright:width,3)=255;
     filter1(heightsearch,imgright:width)=0;
        

end
% search length
filter2 = ones(height,width);
for widesearch = 1:width
detectBlack = false;
detectWhite = false;
imgup=1;
    for heightsearch =  1:height
        if I_close(heightsearch,widesearch) == false  
           detectBlack = true;
        end
        if (I_close(heightsearch,widesearch) == true) && (detectBlack == true )
           imgup = heightsearch;
           break;
        end
    end
     filtedImg(1:imgup,widesearch,1)=255;
     filtedImg(1:imgup,widesearch,2)=255;
     filtedImg(1:imgup,widesearch,3)=255;
     filter2(1:imgup,widesearch,2)=0;
        

end
for widesearch =  1:width
detectBlack = false;
detectWhite = false;
imgdown=1;
    for heightsearch = height:-1:1
        if I_close(heightsearch,widesearch) == false  
           detectBlack = true;
        end
        if (I_close(heightsearch,widesearch) == true) && (detectBlack == true )
           imgdown = heightsearch;
           break;
        end
    end
     filtedImg(imgdown:height,widesearch,1)=255;
     filtedImg(imgdown:height,widesearch,2)=255;
     filtedImg(imgdown:height,widesearch,3)=255;
     filter2(imgdown:height,widesearch)=0;
        

end
%% another filter to the picture
I_bw = im2bw(filtedImg,0.8);
s = strel('disk',10);% define the brush
I_close = imclose(I_bw,s); % fill the small clapse
I_close= ones(height,width) - I_close;


L = bwlabel(I_close);% lable the connected same piexel region 
stats = regionprops(L); % get the labled information,such as area, BoundingBox,...

Ar = cat(1, stats.Area);% label the size of each 
ind = find(Ar ==max(Ar));%find the biggest area lable. 
I_close(find(L~=ind))=0;%fill the hole of other places






%% output of the image
subplot(2,2,1);imshow(filtedImg);title('result iamge before filter');subplot(2,2,2), imshow(I_close);title('the edge ');
subplot(2,2,3), imshow(img);title('the origin ');




