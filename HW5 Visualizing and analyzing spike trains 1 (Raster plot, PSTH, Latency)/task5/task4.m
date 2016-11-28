% load results from previous tasks
clear
load NDA_task3_results
load NDA_stimulus
 


%%   Raster 
for i = 1 :  numel(spikeTimes)



    figure(i+100)
    Train=plotRasters(spikeTimes{i}, stimulusOnset, direction, stimulusDuration);
end

%%  Plot PSTH 
for i = 1 :  numel(spikeTimes)

        

    wbin= 2000/80;
    figure(i);
    Case = 1; 
    plotPsth(spikeTimes{i}, stimulusOnset, direction, stimulusDuration,wbin,Case);
end

%% calculate cost function Cm
   
for i = 1 :  numel(spikeTimes)
     dT = 2; Case = 2; % do not plot histogram.
     for n = 1 : 100
        wbin = dT*n; 
        clear Values
        
        [Values]=plotPsth(spikeTimes{i}, stimulusOnset, direction, stimulusDuration,wbin,Case);
         
        Values_binwise{n}= Values;
        sum_Values = sum(Values_binwise{n},2);  % average for all directions
        Mean = mean(sum_Values);
        Variance = var(sum_Values); %average variance for all directions
        Cm(n,i) =  (2*Mean - Variance)./((176* wbin)^2);
    
     end   
end

%% Plot Cost function over binwidths.
     
figure(5) 

    for i = 1: numel(spikeTimes) 
      s = linspace(10,200,100);
      MinCost(i) = find( Cm(:,i) == min(Cm(:,i) ));   
      subplot(4,1,i)
      plot(s,Cm(:,i))
        
      if i ==  1;
         title('Cost Function of different bin size for neuron 1 to 4');
      end
      
      xlabel('binwidth, ms')
    end


  
%% plot optimal situation

Case = 1; % plot histogram

for i = 1 :numel(spikeTimes)
      
     
    figure(5+i)
     
     wbin = MinCost(i)*2; 
     Edge = -500:wbin:2500;
     clear Optimal
     [Optimal]=plotPsth(spikeTimes{i}, stimulusOnset, direction, stimulusDuration,wbin,Case);

    
      psth{i} = Optimal; 
      [~,ord]= max(sum(Optimal));
      best(i) = ord;             % direction with max #spikes
    

end  

             
      


%% Lineartity Index

figure(10)
for i  = 1 : numel(spikeTimes)
Best_psth = psth{i}(:,best(i)); 
wbin = MinCost(i)*dT;
fs  =  1000/(wbin);
range =[3.4-0.005 3.4 + 0.005];
% Intensity =bandpower(Best_psth,fs,range);
% base      =bandpower(Best_psth,fs,0 0.001]);
% Ratio(i) = Intensity/base;
% Edge = 0:wbin:2000;
% fit_psth = fit(Edge', (Best_psth-mean(Best_psth)),'sin1');

[Ratio,fit_psth]=linearityIndex(Best_psth,fs,range);
 Edge = 0:wbin:2000;
ratio(i)= Ratio;
subplot(4,1,i)
bar(Edge, Best_psth);
set(gca,'xlim',[0 2000]);

hold on
s = 0:1:2000;
fit_psth_real=fit_psth(s)+mean(Best_psth);
plot(s, fit_psth_real);
j = sprintf('ratio = %d',Ratio)
title(j);
xlabel('time (ms)')
ylabel('spike rate (Hz)')
hold off
end
