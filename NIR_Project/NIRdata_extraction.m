%feature selection based on the Matlab libarary 

for picnum=1:200
    data = load("E:\ARP\Pictures_20200615\Durchgefärbt1\"+num2str(picnum)+".mat");
    NIRdata(picnum,:)=data.data.hcam;
    %NIRdata(picnum,225)=1;
 
end

for picnum=1:200
    data = load("E:\ARP\Pictures_20200615\Durchgefärbt2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdata(picnum,225)=1;
 
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;
for picnum=1:200
    data = load("E:\ARP\Pictures_20200615\gKarton1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdata(picnum,225)=2;
 
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;
for picnum=1:91
    data = load("E:\ARP\Pictures_20200615\gKarton2\"+num2str(picnum+9)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdata(picnum,225)=2;
 
end
NIRdata=[NIRdata;NIRdatanew];

for picnum=1:91
    data = load("E:\ARP\Pictures_20200615\gKarton2\"+num2str(picnum+109)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdata(picnum,225)=2;
 
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum=1:200
    data = load("E:\ARP\Pictures_20200615\gPapier1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=3;
   
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\gPapier2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Magazine1\"+num2str(picnum)+".mat");
   
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=4;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Magazine2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=4;
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Wellpappe1\"+num2str(picnum)+".mat");
     NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=5;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Wellpappe2\"+num2str(picnum)+".mat");
     NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=5;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Werbehefte1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=6;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Werbehefte2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=6;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum= 1:94
    data = load("E:\ARP\Pictures_20200615\wKarton1\"+num2str(picnum+6)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=7;
   
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum= 1:94
    data = load("E:\ARP\Pictures_20200615\wKarton1\"+num2str(picnum+106)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=7;
   
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum= 1:52
    data = load("E:\ARP\Pictures_20200615\wKarton2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=7;
   
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum= 1:52
    data = load("E:\ARP\Pictures_20200615\wKarton2\"+num2str(picnum+100)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=7;
   
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum= 1:200
    data = load("E:\ARP\Pictures_20200615\wPapier1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=8;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\wPapier2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=8;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\wWellpappe1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=9;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum =1:200
    data = load("E:\ARP\Pictures_20200615\Zeitungen1\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=10;
    
end
NIRdata=[NIRdata;NIRdatanew];
clear NIRdatanew;

for picnum= 1:200
    data = load("E:\ARP\Pictures_20200615\Zeitungen2\"+num2str(picnum)+".mat");
    NIRdatanew(picnum,:)=data.data.hcam;
    %NIRdatanew(picnum,225)=10;
    
end
NIRdata=[NIRdata;NIRdatanew];


