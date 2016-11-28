%function plotSeparation(b, mu, Sigma, priors, assignment, varargin)
% Plot cluster separation by projecting on LDA axes
%   plotSeparation(b, mu, Sigma, priors, assignment) visualizes the cluster
%   separation by projecting the data on the LDA axis for each pair of
%   clusters. Each column is normalized such that the left (i.e. first)
%   cluster has zero mean and unit variances. The LDA axis is estimated
%   from the model.



for  k = 1: 9
   B{k}= b(assignments==k,:);  
end


% computing cluster linear discrimination vector w





colors= hsv(9); 
figure(8)
for r=1:9
   for c=1:9
     if r~=c

       u=(mu(r,:)-mu(c,:));
       S = cov(B{r})+cov(B{c});
       U= inv(S)*u';
       L= sqrt(U'*U); %normalization constant
       W{r,c}= U./L;
       H1= B{r}*W{r,c};
       H2= B{c}*W{r,c};
       
       p1 =subplot(9,9,9*(r-1)+(c));
       mx=mean(H1);
       SD=std(H1);
       h1=histogram((H1-mx)/SD,50,'FaceColor',colors(c,:));
              Y_Max=max(h1.Values);
              h1.FaceAlpha=0.8;
              h1.EdgeColor='none'; 
              ylim Manual
              ylim([ 0 Y_Max]);
              xlim Manual
              xlim([-4 4])
       hold on
       
       
        h2=histogram((H2-mx)/(SD),50,'FaceColor',colors(r,:));
          h2.FaceAlpha=0.6;
          h2.EdgeColor='none';
          set(gca,'xtick',[])
          set(gca,'xticklabel',[])
          set(gca,'ytick',[])
          set(gca,'yticklabel',[])

       hold off
     end
   end 
end
