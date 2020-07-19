function [Percentage] = checkAndPlot(truematrix,predictmatrix)
%CHECKANDPLOT Return the overall correctness and confused matrix
% the sequence of the input is inportant!!
% the input can bw column or row arrey
% input: 
% true classification, predicted classification
% output:
% a plot of the confusematrix and the percentage of the overall correctness
% Example:
% [Percentage] = checkAndPlot(truematrix,predictmatrix)

%% Code
% the difference in the classifiction results
difference = truematrix-predictmatrix;
% the id is the logic matrix show 1 at the position of all right matrix
id = difference ==0;
% get the number of the object
[n m]= size(truematrix);
% if 1*n and n*1 are the same
if(n==1)
    n=m;
end
Percentage = sum(id)/n;
%% plot the confusematrix
cm = confusionchart(truematrix,predictmatrix, ...
'Title','ConfuseMatrix', ...
'RowSummary','row-normalized', ...
'ColumnSummary','column-normalized');
end

