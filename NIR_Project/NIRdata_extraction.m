%feature selection based on the Matlab libarary 

parfor picnum=1:200
    data = load("E:\ARP\Pictures_NEW\Durchgefärbt1\"+num2str(picnum)+".mat");
    NIRdata(picnum,:)=data.data.hcam;
    %NIRdata(picnum,225)=1;
 
end

parfor picnum=1:200
    data = load("E:\ARP\Pictures_NEW\gPapier1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=2;
   
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\gPapier2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\Magazine1\"+num2str(picnum)+".mat");
   
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=3;
    
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\Magazine2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=3;
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\Wellpappe1\"+num2str(picnum)+".mat");
     NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=4;
    
end
NIRdata=[NIRdata;NIRdatanew];



parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\Werbehefte1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=5;
    
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\Werbehefte2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=5;
    
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum= 1:200
    data = load("E:\ARP\Pictures_NEW\wPapier1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=6;
    
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\wPapier2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=6;
    
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum =1:200
    data = load("E:\ARP\Pictures_NEW\Zeitungen1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=7;
    
end
NIRdata=[NIRdata;NIRdatanew];

parfor picnum= 1:200
    data = load("E:\ARP\Pictures_NEW\Zeitungen2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=7;
    
end
NIRdata=[NIRdata;NIRdatanew];


