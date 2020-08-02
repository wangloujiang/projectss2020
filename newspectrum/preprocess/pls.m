function pls(traindata,ncomp) 
feature=traindata(:,1:224);
response=traindata(:,225);
responsenew=[];
[n,m]=size(feature);
%get response matrix
for i=1:n 
    num=response(i);
    new(1,1:10)=0;
    new(1,num)=1;
    responsenew=[responsenew;new];
end
    
%response=diag(response);

%select ROI 
feature=feature(:,10:210);
%standarlization according to each row 
feature=zscore(feature,0,2);
%1.Derivate 
derivate=1;
order=3;
window=11;
[~,g] = sgolay(order,window);
for i = 1:size(feature,1)    
               feature(i,:) = conv(feature(i,:)', factorial(derivate) * g(:,derivate+1), 'same');
    end
%standardlization according to each colum 
meanvalue=mean(feature);
stdvalue=std(feature);
feature= (feature-meanvalue)./stdvalue;


%for i = 1:n
 %   offset=mean(feature2(i,1:5));
  %  vector(1,1:224)=offset;
   % feature2(i,:)=feature2(i,:)-vector;
    %feature(i,:)=feature2(i,6:224);
%end
%feature=normalize(feature);
[Xloadings,Yloadings,Xscores,Yscores,betaPLS10,PLSPctVar,~,v_pls] = plsregress(feature,responsenew,ncomp);
featurereduced=Xscores;
feature4pls= [featurereduced,response];
save('pls4training.mat','feature4pls');
save('plsvector.mat','v_pls');
save('meanvalue.mat','meanvalue');
save('stdvalue.mat', 'stdvalue');
end

