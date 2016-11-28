close all
clf
clear

% load data
load NDA_task6_data
load NDA_stimulus

% test for significant tuning



dirs = unique(direction);
%n = numel(spikeTimes);
%p = zeros(1, n);


select = [13,20,21,22,27,28,29,30,31,37,38];
%select = 1:41;

figure(1)

for i = 1 : length(select)
    
  subplot(4,3,i)    
    
      n = select(i);
      counts = getSpikeCounts(spikeTimes{n}, stimulusOnset, direction, stimulusDuration);
    
      for j = 1: 16   % # trails

         M_plot(j) = mean(counts(j,11*(j-1)+1:11*j)) ;        
         V_plot(j) = (var(counts(j,11*(j-1)+1:11*j)))^(1/2) ; 

      end
      
      errorbar(M_plot(:),V_plot(:),'b-.');  
      
      hold on  
      
      [f,q0(i)] = fitCos(dirs, counts);  
      plot(f,'r-')  
      
      [p(1,i),q(i,:), qdistr(i,:)] = testTuning(dirs, counts);  
     
      spring = sprintf ('%d th neuron', select(i)) ;  
       
      title(spring);    
      axis tight 
      hold off   
      
      
       
end
fprintf('%d of %d cells are tuned at p < 0.01\n', sum(p < 0.01), n)

% plot a few nice ones
%%
figure(100)

i = 2;

Edge = qdistr(i,:);
Value = q(i,:);

bar(Edge(1:end-1)+diff(Edge),Value);
hold on
ax = gca; 
ax_y= ax.YLim ; 
line([q0(i) q0(i)] ,ax_y);

xlabel('|q|')
ylabel('number')
title('figure 2 Finding p value')


