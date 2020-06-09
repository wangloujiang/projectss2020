hold on 
for i = 1:66
    x = 1:224;
    y = ones(1,224).*i;
    z = dataCaCO3(i,1:224);
    plot3(x,y,z)
end