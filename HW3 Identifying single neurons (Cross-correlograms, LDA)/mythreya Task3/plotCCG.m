function plotCCG(t, assignments, varargin)
% Plot cross-correlograms of all pairs.
%   plotCCG(t, assignment) plots a matrix of cross(auto)-correlograms for
%   all pairs of clusters. Inputs are:
%       t           vector of spike times           #spikes x 1
%       assignment  vector of cluster assignments   #spikes x 1

[ccg,bins] = correlogram(t,assignments,0.5,20);
n=9;
colors= hsv(n);
%plot the ccg matrix
f = figure(2);
f.Name = 'Cross Correlograms of all clusters';
for i = 1:n
    for j= 1:n
        
    subplot(n,n,(((i-1)*n) + j));
    if i==j
    b1 = bar(ccg(:,i,j),'FaceColor',colors(i,:));
    elseif i~=j
    b1 = bar(ccg(:,i,j),'FaceColor',[0.1 0.1 0.1]);

    end
    b1.EdgeColor='none'
    axis off
    
    end
end