function [Values]=plotPsth(spikeTimes, stimOnsets, direction, stimDuration,wbin,Case)
% Plot peri-stimulus time histograms (PSTH).
%   plotPsth(spikeTimes, stimOnsets, directions, stimDuration) plots the
%   PSTHs for one single unit for all 16 stimulus conditons. Inputs are:
%       spikeTimes      vector of spike times           #spikes x 1
%       stimOnsets      vector of stimulus onset times (one per trial)
%                                                       #trials x 1
%       directions      vector of stimulus directions (one per trial)
%                                                       #trials x 1
%       stimDuration    duration of stimulus presentation in ms
%                                                       scalar


%       wbin            bin width
%       case           { print histogram, not print histogram } = { 1 , 2 }

% plotting parameters
    
preStim = 0;
postStim = 0;

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
 %%
 
  clf
  shift0 = [1; direction_sort]; shift1= [direction_sort;1]; ind = (shift1~=shift0); 
  angles = direction_sort(ind(1:end-1));
  label = sprintf('%s',angles);
  label_ind  =  find(ind(1:end-1)==1);

    
    
   
        Edge= -preStim:wbin:(stimDuration+ postStim);
        clear Values 

        %figure()

        for i  = 1: length(label_ind)   % for each direction 
           M=[];         
           for d= 1:11 ; M= [M;Train{label_ind(i)+d-1}];end   
            
           subplot(length(label_ind),1,i)

        h = histogram(M.*(1/11).*(1/wbin),length(Edge));
        h.EdgeColor = 'none';
        h.FaceColor = 'none';
         switch (Case)
            
            case  1  
              h.EdgeColor = 'k';
              h.FaceColor = 'k';
        
            case  2
              h.EdgeColor = 'none';
              h.FaceColor = 'none';      
         end
         
         Values(:,i) = h.Values;
        
        
        
           if i ==  1;
             q = sprintf('with optimized bin size %d ms', wbin);
             title(q);
           end

           if i <16 
            ax1 = gca;
            set(ax1, 'xTickLabel',[],'xTick',[]);
           else 
            xtick = get(gca,'xTick');
            set(gca,'xTickLabel',linspace(-preStim, stimDuration+postStim, length(xtick)));
           end
            
           if i==16; xlabel('Time relative to stimulus onsets (ms)'); end;% Time is in second
    
      end
      
       
end



