clc
clear
maindir = 'E:\ARP\Pictures_20200615';
subdir  = dir( maindir );

for i = 3 : length( subdir )
    subdirpath = fullfile( maindir, subdir( i ).name, '*.mat' );
    mat = dir( subdirpath );  % 子文件夹下找后缀为mat的文件
    if (mat(1).folder(end)=='2')||(mat(1).folder(end)=='3')||(mat(1).folder(end)=='4')
        index=strcat('\',mat(1).folder(end),'_');        %index，存储命名格式
 
    else
        rewriteposition=strrep(mat(1).folder,'Pictures_20200615','img2');
        if mat(1).folder(end)=='1'
            index='\1_';
            rewriteposition(end)='';
        else
            index='\';
        end
        mkdir(rewriteposition);
    end
    for j = 1 : length( mat )
        matpath = fullfile( maindir, subdir( i ).name, mat( j ).name);
        %% img preprocessing
        load( matpath );
        A=data.camW;
        %插入预处理
        imsize=400;
        step=100;
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
        

        %% write
        changeformat=strrep(mat( j ).name,'.mat','.jpg');
        newname=strcat(rewriteposition,index,changeformat);    
        imwrite(A,newname);
    end
end