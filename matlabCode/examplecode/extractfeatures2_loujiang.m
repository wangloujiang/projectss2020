
featuresnew= zeros(200,24);

parfor picnum = 1:200
    
    a = ImageDataAnalyzer2_loujiang;
    data = load("D:\Pictures\Pictures_20200615\wWellpappe1\"+num2str(picnum)+".mat")
    
    a.extractFeatures(data.data.camW,data.data.camWUV,data.data.scale);
    featuresnew(picnum,:)=a.features;
end


% get the id of the no scale part.
id = featuresnew(:,1)==404;
a = 1:200;
problemid = id .* a';
id = featuresnew(:,1)~=404;
problemid(id) =[];