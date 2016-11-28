function plotClusters(b,assignments,clusters, channels)

%this function plots the scatter plots of the clusters
% Arguments: 
%            b - matrix of spikes #spikes * #dimensions
%     clusters - string of cluster numbers that 
%                are to be plotted. eg: '1356' plots clusters 1,3,5 and 6
%     Channels - 2 of the 12 pca components to be plotted against
%                for eg: when channel 1 pca1 vs channel3 pca1 => [1 7]



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

colors = hsv(9);


% Assign individual clusters
for i=1:size(b,1)

    clu1(i) = (assignments(i)==1);
    clu2(i) = (assignments(i)==2);
    clu3(i) = (assignments(i)==3);
    clu4(i) = (assignments(i)==4);
    clu5(i) = (assignments(i)==5);
    clu6(i) = (assignments(i)==6);
    clu7(i) = (assignments(i)==7);
    clu8(i) = (assignments(i)==8);
    clu9(i) = (assignments(i)==9);
    
    Big={ clu1,clu2,clu3,clu4,clu5,clu6,clu7,clu8,clu9};
end

 figure(1)
 hold on
 
 if((isempty(strfind(clusters,'1')))==0)
 scatter(b(clu1,channels(1)),b(clu1,channels(2)),20,'.','MarkerFaceColor',colors(1,:))
 forlegend = 'Cluster1';
 end

 if((isempty(strfind(clusters,'2')))==0)
 scatter(b(clu2,channels(1)),b(clu2,channels(2)),20,'.','MarkerFaceColor',colors(2,:))
 forlegend = cat(1,forlegend,'Cluster2');
 end
 
 if((isempty(strfind(clusters,'3')))==0)
 scatter(b(clu3,channels(1)),b(clu3,channels(2)),20,'.','MarkerFaceColor',colors(3,:))
 forlegend = cat(1,forlegend,'Cluster3');
 end
 
 if((isempty(strfind(clusters,'4')))==0)
 scatter(b(clu4,channels(1)),b(clu4,channels(2)),20,'.','MarkerFaceColor',colors(4,:))
 forlegend = cat(1,forlegend,'Cluster4');
 end
 
 if((isempty(strfind(clusters,'5')))==0)
 scatter(b(clu5,channels(1)),b(clu5,channels(2)),20,'.','MarkerFaceColor',colors(5,:))
 forlegend = cat(1,forlegend,'Cluster5');
 end
 
 if((isempty(strfind(clusters,'6')))==0)
 scatter(b(clu6,channels(1)),b(clu6,channels(2)),20,'.','MarkerFaceColor',colors(6,:))
 forlegend = cat(1,forlegend,'Cluster6');
 end
 
 if((isempty(strfind(clusters,'7')))==0)
 scatter(b(clu7,channels(1)),b(clu7,channels(2)),20,'.','MarkerFaceColor',colors(7,:))
  forlegend = cat(1,forlegend,'Cluster7');
 end
 
 if((isempty(strfind(clusters,'8')))==0)
 scatter(b(clu8,channels(1)),b(clu8,channels(2)),20,'.','MarkerFaceColor',colors(8,:))
 forlegend = cat(1,forlegend,'Cluster8');
 end
 
 if((isempty(strfind(clusters,'9')))==0)
 scatter(b(clu9,channels(1)),b(clu9,channels(2)),20,'.','MarkerFaceColor',colors(9,:))
 forlegend = cat(1,forlegend,'Cluster9');
 end
for i = 1:9
 
 MP(i,:) = [mean(b(Big{i},channels(1))),mean(b(Big{i},channels(2))) ];
 scatter(MP(:,1),MP(:,2),'ko','LineWidth',2)

end


 
 xlabel('Channel 1 1st PCs');
 ylabel('Channel 3 1st PCs');
 leg=legend(forlegend);
 leg.Box='off';
 leg.Units='points';
 leg.FontSize= 12;
 leg.FontWeight ='bold';
 
 
 title('Scatter plot of spike clusters')
 
hold off
