function counts = getSpikeCounts(spikeTimes, stimOnsets, directions, stimDuration)
% Get firing rate matrix for stimulus presentations.
%   counts = getSpikeCounts(spikeTimes, stimOnsets, directions, stimDuration)
%   Inputs:
%       spikeTimes      vector of spike times           #spikes x 1
%       stimOnsets      vector of stimulus onset times (one per trial)
%                                                       #trials x 1
%       directions      vector of stimulus directions (one per trial)
%                                                       #trials x 1
%       stimDuration    duration of stimulus presentation in ms
%                                                       scalar
%   Output: 
%   counts      matrix of spike counts during stimulus presentation. The
%               matrix has dimensions #trials/direction x #directions
  
    
     Train =plotRasters(spikeTimes, stimOnsets, directions, stimDuration,0);
     
      for j = 1: numel(Train)   % # trails  
        
         row = floor((j-1)/11) + 1 ;          
         counts(row,j) = sum(Train{j}~=0);     
         
      end

end







