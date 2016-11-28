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


Prime_select = [6,13,21,28,29,37,38];% neurons with p <0.01
select = 1:41;

figure(1)

for i = 1 : length(select)
    
  subplot(7,7,i)    
    
      n = select(i);
      counts = getSpikeCounts(spikeTimes{n}, stimulusOnset, direction, stimulusDuration);
    
      for j = 1: 16   % # trails

         M_plot(j) = mean(counts(j,11*(j-1)+1:11*j)) ;        
         V_plot(j) = (var(counts(j,11*(j-1)+1:11*j)))^(1/2) ; 

      end
      
      errorbar(dirs,M_plot(:),V_plot(:),'b-.');  
      
      hold on  
      
      [f,q0(i)] = fitCos(dirs, counts);  % q0 here is still complex numbers probably with negative real parts
      
      plot(dirs,f,'r-')  
      
      [p(1,i),q(i,:), qdistr(i,:)] = testTuning(dirs, counts);  
     
      spring = sprintf ('%d th neuron', select(i)) ;  
       
      title(spring);    
      axis tight 
      hold off   
      
      % stores counts
      cellcount(i,:,:)  = counts;
      Mcountcell(i,:) = M_plot;
      Vcountcell(i,:) = V_plot;
      cosfitcell(i,:) = f;
end

tuned_select = find(p < 0.01); 
fprintf('%d of %d cells are tuned at p < 0.01\n', sum(p < 0.01), n)
%matched = p < 0.01

% plot a few nice ones
%%
figure(100)
clf
i = 2;

Edge = qdistr(i,:);
Value = q(i,:);

bar(Edge(1:end-1)+diff(Edge),Value);
hold on
ax = gca; 
ax_y= ax.YLim ; 
q0 = abs(q0);
line([q0(i) q0(i)] ,ax_y);

xlabel('|q|')
ylabel('number')
title('figure 2 Finding p value')

%% least square Fit von Mises selecting 2 cells

n1 = Prime_select(6);
n2 = Prime_select(5);


cell6(:,:) = (cellcount(n1,:,:));
params6 = fitLS(dirs, Mcountcell(n1,:));

cell6fit = tuningCurve(params6,dirs);


cell3(:,:)  = (cellcount(n2,:,:));
params3 = fitLS(dirs, Mcountcell(n2,:)); 

cell3fit = tuningCurve(params3,dirs);



figure(5)

subplot(2,1,1)
errorbar(dirs,Mcountcell(n1,:),Vcountcell(n1,:),'b-.');

hold on
title('Comparison of Cosine and von Mises fit ');
plot(dirs,cosfitcell(n1,:),'g');
plot(dirs,cell6fit,'r');

hold off
str1 = sprintf('the %d th neuron with least square vonMises fit',(n1));
title(str1);
axis tight
xlabel('Stimulus Orientation ');
ylabel('Spike Count');
legend('Spike count error bar', 'cosine fit', 'von Mises fit');


subplot(2,1,2)
errorbar(dirs,Mcountcell(n2,:),Vcountcell(n2,:),'b-.');
hold on
plot(dirs,cosfitcell(n2,:),'g');
plot(dirs,cell3fit,'r');

hold off
axis tight
str1 = sprintf('the %d th neuron with least square vonMises fit',(n2));
title(str1);
xlabel('Stimulus Orientation');
ylabel('Spike Count');
legend('Spike count error bar', 'cosine fit', 'von Mises fit');

%% Poisson noise fit von Mises 

n1 = Prime_select(6);
n2 = Prime_select(5);



cell6(:,:) = (cellcount(n1,:,:));
[params6_1,I(1,:),iter(1)] = fitML(dirs, Mcountcell(n1,:));

cell6poiss = tuningCurve(params6_1,dirs);


cell3(:,:)  = (cellcount(n2,:,:));
[params3_1,I(2,:),iter(2)]= fitML(dirs, Mcountcell(n2,:)); 

cell3poiss = tuningCurve(params3_1,dirs);


% I is the initial values of the params of von Mises model, and iter is the
% number of iteration needed to converge to minimum.

figure(6)
clf

subplot(2,1,1)
errorbar(dirs,Mcountcell(n1,:),Vcountcell(n1,:),'b-.');

hold on
title('Comparison of Cosine and von Poisson Mises fit ');
plot(dirs,cosfitcell(n1,:),'g-.');
plot(dirs,cell6fit,'k-*')

plot(dirs,cell6poiss,'r');

hold off
axis tight
str1 = sprintf('the %d th neuron with ML vonMises fit', (n1));
title(str1);
xlabel('Stimulus Orientation');
ylabel('Spike Count');
legend('Spike count error bar', 'cosine fit','von Mises LS','von Mises ML');


subplot(2,1,2)
errorbar(dirs,Mcountcell(n2,:),Vcountcell(n2,:),'b-.');
hold on
plot(dirs,cosfitcell(n2,:),'g-.');
plot(dirs,cell3fit,'k-*')
plot(dirs,cell3poiss,'r');

hold off
axis tight
str1 = sprintf('the %d th neuron with ML vonMises fit', (n2));
title(str1);
xlabel('Stimulus Orientation');
ylabel('Spike Count');
legend('Spike count error bar', 'cosine fit','von Mises LS', 'von Mises ML');
