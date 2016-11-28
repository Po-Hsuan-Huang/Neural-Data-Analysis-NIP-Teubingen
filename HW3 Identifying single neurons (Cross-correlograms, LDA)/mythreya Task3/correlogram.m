function [ccg, bins] = correlogram(t, assignment, binsize, maxlag)
% Calculate cross-correlograms.
%   ccg = calcCCG(t, assignment, binsize, maxlag) calculates the cross- and
%   autocorrelograms for all pairs of clusters with input
%       t               spike times             #spikes x 1
%       assignment      cluster assignments     #spikes x 1
%       binsize         bin size in ccg         scalar
%       maxlag          maximal lag             scalar
% 
%  and output
%       ccg             computed correlograms   #bins x #clusters x
%                                                               #clusters
%       bins            bin times relative to center    #bins x 1


%% for each spike time 

% Init variables
% ccg dimensions are #bins*#clusters*#clusters
% #bins = total bin length / bin size
ccg = zeros(maxlag*2/binsize,9,9);


for i = 1:size(t,1)
   binidx =0;
    % center the bin on the first spike
    % and increment by bin size
    for j = t(i)-maxlag:binsize:(t(i)+maxlag-binsize)
       binidx = binidx + 1;
       % if another spike time is found within this bin
       % then find its cluster number and update that clusters bin
       idx = find((j<t) & (t<(j+binsize)));
       if(isempty(idx)==0)
           for k=1:size(idx)
            ccg(binidx,assignment(i),assignment(idx(k))) =  ccg(binidx,assignment(i),assignment(idx(k))) +1;
            %ccg(binidx,assignment(idx(k)),assignment(i)) = ccg(binidx,assignment(i),assignment(idx(k)));
           end
       end

    end
    
end
bins = ccg(:,1,1)
