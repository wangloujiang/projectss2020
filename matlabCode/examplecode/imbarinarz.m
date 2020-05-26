%% quick check of the method imbinary
img = imread("2002_1.jpg");
roi = [200 70 1733 2525];
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
I_bw= I_bw.*mask;
figure
imshowpair(img,I_bw,'montage')

s = strel('disk',10);% define the brush
I_close = imclose(I_bw,s); % fill the small clapse
imshow(I_close)
subplot(1,2,1);imshow(img);title('result iamge');subplot(1,2,2), imshow(I_close);title('the edge ');

% L = bwlabel(I_close);% lable the connected same piexel region 
% stats = regionprops(L); % get the labled information,such as area, BoundingBox,...
% 
% Ar = cat(1, stats.Area);% label the size of each 
% ind = find(Ar ==max(Ar));%find the biggest area lable. 
% I_close(find(L~=ind))=0;%fill the hole of other places
% 
% status=regionprops(I_close,'BoundingBox');%get the leaset rectangular surrounding the place
% statuss = cat(1, status.BoundingBox);% locate the rectangular
% 
% a = round(statuss(1));
% b = round(statuss(2));
% h = round(statuss(3));
% w = round(statuss(4));


