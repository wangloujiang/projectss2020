data1=nirmix(:,1:224);
data2=nir(:,1:224);
idx=0;
for i = 1:993 
compare1=data1(i,:);
for j= 1:3000
    compare2=data2(j,:);
    if compare1 == compare2
        idx=idx+1;
    end
end
end