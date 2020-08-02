feature2=train(:,1:224);
[n,m]=size(feature2);
for i = 1:n
    offset=mean(feature2(i,1:5));
    vector(1,1:224)=offset;
    feature2(i,:)=feature2(i,:)-vector;
   
    feature(i,:)=feature2(i,6:224);
end