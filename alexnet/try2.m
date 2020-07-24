load('E:\ARP\Pictures_20200615\Durchgefärbt1\36.mat')
roiAC = [170 2585 70 2100]; 
A=data.camW;
A = A(roiAC(3):roiAC(4),roiAC(1):roiAC(2),:);
SumA=sum(A,3);
A=imresize(A,[227,227]);
imshow(A);
