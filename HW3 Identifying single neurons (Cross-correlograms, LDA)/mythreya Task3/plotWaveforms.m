function plotWaveforms(w, assignment)
% Plot waveforms for each cluster.
%   plotWaveforms(w, assignment) plots for all four channels of each
%   cluster 100 sample waveforms, overlaid by the average waveform. All
%   panels are drawn on the same scale to facilitate comparison.
%   Argument cluster_number tells the cluster for which waveforms are to be
%   plotted

%% sort waveforms belonging to the given cluster 

% some variable inits

% To keep the color coding of each cluster consistent
colors = [
[1 1 0]%'y'
[1 0 1]%'m'
[0 1 1]%'c'
[1 0 0]%'r'
[0 1 0]%'g'
[0 0 1]%'b'
[0 0.5 1]%'w'
[1 0.5 0]%'k'
[0 0 0]
];

colors=hsv(9);
% set Y axis limits so that all plots are comparable in scale
ymin = -150;
ymax = 150;

% coutner to get the first 100 spikes for all 9 clusters
count = ones(9);

% 100 spikes of all channels for each cluster
wcluster = zeros(32,100,4,9);

% Loop thru all spikes and assign them to respective clusters
for i=1:size(assignment,1)
    
if ((assignment(i)== 1) && (count(1) < 101))
        wcluster(:,count(1),:,1) = w(:,i,:);
        count(1) = count(1) +1;
end

if ((assignment(i)== 2) && (count(2) < 101))
        wcluster(:,count(2),:,2) = w(:,i,:);
        count(2) = count(2) +1;
end

if ((assignment(i)== 3) && (count(3) < 101))
        wcluster(:,count(3),:,3) = w(:,i,:);
        count(3) = count(3) +1;
end

if ((assignment(i)== 4) && (count(4) < 101))
        wcluster(:,count(4),:,4) = w(:,i,:);
        count(4) = count(4) +1;
end

if ((assignment(i)== 5) && (count(5) < 101))
        wcluster(:,count(5),:,5) = w(:,i,:);
        count(5) = count(5) +1;
end

if ((assignment(i)== 6) && (count(6) < 101))
        wcluster(:,count(6),:,6) = w(:,i,:);
        count(6) = count(6) +1;
end

if ((assignment(i)== 7) && (count(7) < 101))
        wcluster(:,count(7),:,7) = w(:,i,:);
        count(7) = count(7) +1;
end

if ((assignment(i)== 8) && (count(8) < 101))
        wcluster(:,count(8),:,8) = w(:,i,:);
        count(8) = count(8) +1;
end

if ((assignment(i)== 9) && (count(9) < 101))
        wcluster(:,count(9),:,9) = w(:,i,:);
        count(9) = count(9) +1;
end


end


%% Compute the average waveform of the cluster/channel


avg_wave(:,:,:,:) = mean(wcluster(:,:,:,:),2);



%% Plot all four channel waveforms for 100 and average waveforms of this cluster

fig = figure(1);

fig.Name = 'Average and 100 waveforms of #channels* #clusters';

hold on;
% xlabel('cluster waveform plots')
% ylabel('Channels')
% title('Average and 100 waveforms of #channels* #clusters')

for plotloop= 1:4

subplot(4,9, ((plotloop-1)*9)+1 );

plot(wcluster(:,1:100,plotloop,1),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,1),'Marker','*','MarkerSize',2,'Color',colors(1,:));
ylim([ymin ymax]);
%legend('100waves','AvgWave')

subplot(4,9,((plotloop-1)*9)+2);

plot(wcluster(:,1:100,plotloop,2),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,2),'Marker','*','MarkerSize',2,'Color',colors(2,:));
ylim([ymin ymax]);

subplot(4,9,((plotloop-1)*9)+3);

plot(wcluster(:,1:100,plotloop,3),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,3),'Marker','*','MarkerSize',2,'Color',colors(3,:));
ylim([ymin ymax]);

subplot(4,9,((plotloop-1)*9)+4);

plot(wcluster(:,1:100,plotloop,4),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,4),'Marker','*','MarkerSize',2,'Color',colors(3,:));
ylim([ymin ymax]);

subplot(4,9,((plotloop-1)*9)+5);

plot(wcluster(:,1:100,plotloop,5),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,5),'Marker','*','MarkerSize',2,'Color',colors(5,:));
ylim([ymin ymax]);
subplot(4,9,((plotloop-1)*9)+6);

plot(wcluster(:,1:100,plotloop,6),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,6),'Marker','*','MarkerSize',2,'Color',colors(6,:));
ylim([ymin ymax]);

subplot(4,9,((plotloop-1)*9)+7);

plot(wcluster(:,1:100,plotloop,7),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,7),'Marker','*','MarkerSize',2,'Color',colors(7,:));
ylim([ymin ymax]);
subplot(4,9,((plotloop-1)*9)+8);

plot(wcluster(:,1:100,plotloop,8),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,8),'Marker','*','MarkerSize',2,'Color',colors(8,:));
ylim([ymin ymax]);
subplot(4,9,((plotloop-1)*9)+9);

plot(wcluster(:,1:100,plotloop,9),'Color',[0 0 0]);
hold on;
plot(avg_wave(:,:,plotloop,9),'Marker','*','MarkerSize',2,'Color',colors(9,:));
ylim([ymin ymax]);
end

hold off;










