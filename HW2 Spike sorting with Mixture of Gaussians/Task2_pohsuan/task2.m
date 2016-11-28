%% Task 2

%% question 1: evaluate clustering with Gaussina Mixure toy data

X=generate_toy(1000);
%% question 2: Implement a Gaussian mixture model. Implement the EM algorithm to fit 
 [mu, Sigma, priors, df, assignments]=sortSpikes(X);

% plot the result
idx= assignments;
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

figure(3)
scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');
scatter(mu(:,1),mu(:,2),'kx','LineWidth',2)
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit')

% specify correct clustering number.

 Mis=misclass_toy(idx);
 
 %% question 3: Model complexity of toy data
 

 BIC=Complexity_critiria(X);
%% question 4: Spike sorting using MoG
% a) Plot BIC
   load ('task2_Raw.mat')
   BIC=Complexity_critiria(b);


%% b) make scatter plot 

figure(5)
X=cat(2,b(:,1),b(:,4));
 [mu, Sigma, priors, df, idx]=sortSpikes(X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');

hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit PCA1 of ch1 vs ch2') 
xlabel('PCA1 ch1');
ylabel('PCA1 ch2');

%%
figure(6)
X=cat(2,b(:,1),b(:,7));
 [mu, Sigma, priors, df, idx]=sortSpikes(X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit PCA1 of ch1 vs ch3') 

figure(7)
X=cat(2,b(:,1),b(:,10));
 [mu, Sigma, priors, df, idx]=sortSpikes(X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit PCA1 of ch1 vs ch4') 

figure(8)
X=cat(2,b(:,4),b(:,7));
 [mu, Sigma, priors, df, idx]=sortSpikes(X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');
xlabel('PCA1 ch2');
ylabel('PCA1 ch3');
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit PCA1 of ch2 vs ch3') 

figure(9)
X=cat(2,b(:,4),b(:,10));
 [mu, Sigma, priors, df, idx]=sortSpikes(X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');
xlabel('PCA1 ch2');
ylabel('PCA1 ch4');
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit PCA1 of ch2 vs ch4') 

figure(10)
X=cat(2,b(:,7),b(:,10));
 [mu, Sigma, priors, df, idx]=sortSpikes(X);
cluster1 = (idx == 1);
cluster2 = (idx == 2);
cluster3 = (idx == 3);

scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');
xlabel('PCA1 ch3');
ylabel('PCA1 ch4');
hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit PCA1 of ch3 vs ch4') 
 



 