featuresnew= zeros(200,224);
featuresnew2= zeros(200,224);

parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Durchgefärbt1\"+num2str(picnum)+".mat")
    featuresnew(picnum,:)= data.data.hcam ; 
end

parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\gPapier1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];

parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\gPapier2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Magazine1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Magazine2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Wellpappe1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Werbehefte1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Werbehefte2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\wPapier1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\wPapier2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Zeitungen1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Zeitungen2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,:)= data.data.hcam ; 
end
featuresnew = [featuresnew;featuresnew2];
