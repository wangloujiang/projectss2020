clc;
tic;
%index =5747;
%img=index_image_rgb{index};

img="D:\Pictures\pic\4_1.jpg";
img=imread(img);
img=im2double(img);
img=img(200:1933,70:2595,:);
s=rgb2gray(img);
s1=imfilter(s,fspecial('laplacian',0),'replicate');

s21=imfilter(s,fspecial('sobel'),'replicate');
s22=imfilter(s,(fspecial('sobel'))','replicate');
s2=abs(s21)+abs(s22);
s2=imfilter(s2,fspecial('average'),[3 3],'replicate');

s3=(s-s1).*s2;
s4=s+s3;
% subplot(2,2,1);
% imshow(s);
% subplot(2,2,2);
% imshow(s2);
% subplot(2,2,3);
% imshow(s3);
% subplot(2,2,4);
% imshow(s4);

% subplot(1,2,1);
% imshow(s);
% subplot(1,2,2);
% imshow(s4);

s = adapthisteq(s4,'clipLimit',0.02);
bw=imbinarize(s,0.25);
bw1=bwareaopen(bw,1000);
se=strel('disk',200);
bw2=imclose(bw1,se);
bw3=imfill(bw2,'holes');
bw_boundry=bwboundaries(bw3,'noholes');

imshowpair(img,bw3,'montage');
hold on;
plot(bw_boundry{1}(:,2),bw_boundry{1}(:,1),'y');
figure();
imshow(label2rgb(labelmatrix(bwconncomp(bw3)),'spring'));

toc;

