%可变参数
imsize=827;
step=100;


load('E:\ARP\Pictures_20200615\Durchgefärbt1\36.mat')
roiAC = [170 2585 70 2100]; 
A=data.camW;
A = A(roiAC(3):roiAC(4),roiAC(1):roiAC(2),:);
SumA=sum(A,3);
Conv=ones(imsize,imsize);
C=[floor((roiAC(4)-roiAC(3))/step+1),floor((roiAC(2)-roiAC(1))/step+1)];
count1=1;
for k=1:step: roiAC(4)-roiAC(3)-imsize+2
    count2=1;
    for g=1:step:roiAC(2)-roiAC(1)-imsize+2
        Sumeachpart=SumA(k:k+imsize-1, g:g+imsize-1).*Conv;
        C(count1,count2)= sum(Sumeachpart(:));
        count2=count2+1;
    end
    count1=count1+1;
end
[x,y]=find(C==max(C(:)));
A=A((x-1)*100+1:(x-1)*100+imsize,(y-1)*100+1:(y-1)*100+imsize,:);
A=imresize(A,[227,227]);
imshow(A);





