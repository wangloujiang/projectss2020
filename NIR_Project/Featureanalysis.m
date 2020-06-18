featuresnew= zeros(200,1);
featuresnew2= zeros(200,1);
betaPCR= beta;
parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\Durchgefärbt1\"+num2str(picnum)+".mat")
    featuresnew(picnum,1)= data.data.hcam * beta(2:225)+beta(1); 
end

parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\gPapier1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225)+beta(1); 
end
featuresnew = [featuresnew;featuresnew2];


parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\gPapier2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\Magazine1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\Magazine2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\Wellpappe1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("E:\ARP\Pictures_NEW\Werbehefte1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Werbehefte2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\wPapier1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\wPapier2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Zeitungen1\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
parfor picnum = 1:200
    data = load("D:\Pictures\Pictures_NEW\Zeitungen2\"+num2str(picnum)+".mat")
    featuresnew2(picnum,1)= data.data.hcam * beta(2:225); 
end
featuresnew = [featuresnew;featuresnew2];
