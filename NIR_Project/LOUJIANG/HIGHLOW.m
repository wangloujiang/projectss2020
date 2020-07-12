%% get the labeled data divided into two classes>high and low with the median as a divider.
% get the medieum
medi = median(dataKaolin(:,225));
% generate the 1,0classification, 1 for high,0 for low 
classnum = ones (72,1);
id = dataKaolin(:,225)< medi;
classnum(id,1)=0;
class= categorical(classnum);