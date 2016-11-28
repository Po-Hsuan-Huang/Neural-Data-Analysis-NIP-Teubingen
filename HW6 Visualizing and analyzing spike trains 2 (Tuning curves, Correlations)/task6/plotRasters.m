function [Train]=plotRasters(spikeTimes, stimOnsets, direction, stimDuration,plot)
% Plot spike rasters.
%   plotRasters(spikeTimes, stimOnsets, directions, stimDuration) plots the
%   spike rasters for one single unitfor all 16 stimulus conditons. Inputs
%   are:
%       spikeTimes      vector of spike times           #spikes x 1
%       stimOnsets      vector of stimulus onset times (one per trial)
%                                                       #trials x 1
%       directions      vector of stimulus directions (one per trial)
%                                                       #trials x 1
%       stimDuration    duration of stimulus presentation in ms
%                                                       scalar
%       plot             plot / not polot   1 / 0
% plotting parameters
preStim = 500;
postStim = 500;

%%  

  [direction_sort,order]=sort(direction);
  stimulusOnset_sort= stimOnsets(order);
  

    for i = 1 : length(stimOnsets)


        I = ( spikeTimes < (stimOnsets(i)+2*1e3+postStim) & spikeTimes >= (stimOnsets(i)-preStim)) ; 

        Train_0{i} = spikeTimes(I) - stimOnsets(i) ;

    end

    for i = 1: length(order)

      Train{i} = Train_0{ order(i)} ; 
      
    end
    


switch plot
    
    case 1
  
%% visulaize data
  clf
  shift0 = [1; direction_sort]; shift1= [direction_sort;1]; ind = (shift1~=shift0); 
  angles = direction_sort(ind(1:end-1));
  label_ind  =  find(ind(1:end-1)==1);

   
    subplot(1,2,1)
    for run = 1:size(Train,2)/2
        
          line( [-preStim stimDuration+postStim], [label_ind(ceil(run/11)) label_ind(ceil(run/11))], 'Color', 'k');
          
          for nspike = 1: length(Train{run})
              s = Train{run}(nspike);
              line([s,s], [run run+1], 'Color', 'k');


          end    
        
    end
    ax1=gca;
    
    set(ax1,'xlim',[-preStim stimDuration+postStim],'ylim',[0 88])
    ax1.YTick = label_ind; 
    ax1.YTickLabel = {'0','22.5','45.0','67.5','90.0','112.5','135.0','157.5','180.0','202.5','225.0','247.5','270.0','292.5','315.0','337.5'};
    xlabel('Time relative to stimulus onsets (ms)'); % Time is in second
    ylabel('direciton of motions (degrees)');
    
    
    
    subplot(1,2,2)
    for run = size(Train,2)/2 + 1 : size(Train,2)
           
        line( [-preStim stimDuration+postStim], [label_ind(ceil(run/11)) label_ind(ceil(run/11))], 'Color', 'k');
        
          for nspike = 1: length(Train{run})
              s = Train{run}(nspike);
              line([s, s], [run-0.4 run+0.4], 'Color', 'k');

          end    
        
    end
 
    ax2=gca;
    
    set(ax2,'xlim',[-preStim stimDuration+postStim],'ylim',[89 176]);
    ax2.YTick = label_ind; 
    ax2.YTickLabel = {'0','22.5','45.0','67.5','90.0','112.5','135.0','157.5','180.0','202.5','225.0','247.5','270.0','292.5','315.0','337.5'};

    xlabel('Time relative to stimulus onsets (ms)'); % Time is in second
    ylabel('direciton of motions (degrees)');
    
end
 end


