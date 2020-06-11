


resultnew  = zeros(6900,25);
resultnew(:,25) = results(:,21);
featuresnew  = zeros(6900,24);

parfor picnum = 1151:6900
    a = ImageDataAnalyzer_loujiang;
    input1 ="D:\Pictures\pic\"+num2str(picnum)+"_1.jpg";
    input2 ="D:\Pictures\pic\"+num2str(picnum)+"_2.jpg";
    input3=results(picnum,1); 
    
    a.extractFeatures(input1,input2,input3);
    featuresnew(picnum,:)=a.features;
end
