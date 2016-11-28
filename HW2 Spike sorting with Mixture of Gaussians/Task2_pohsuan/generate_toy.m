function [X]=generate_toy(num)
%Generate toy data: Sample 1000 data points from a two dimensional mixture
%of Gaussian model with three clusters and the following parameters:
rng default;  % For reproducibility, or rng seed is viable

mu1 = [0 0];
sigma1 = [1 0; 0 1];

mu2 = [5 1];
sigma2 = [2 1; 1 2];

mu3 =[0 2] ;
sigma3 = [1 -0.5;-0.5 1];

num = 1000;


figure(1)
X1 = [mvnrnd(mu1,sigma1,num*0.3)];
mean1= mean(X1);
scatter(X1(:,1),X1(:,2),10,'filled');
hold on
X2 = [mvnrnd(mu2,sigma2,num*0.5)];
scatter(X2(:,1),X2(:,2),10,'filled');
mean2= mean(X2);

hold on
X3 = [mvnrnd(mu3,sigma3,num*0.2)];
scatter(X3(:,1),X3(:,2),10,'filled')
mean3= mean(X3);

hold on 
MP= [mean1;mean2;mean3];
scatter(MP(:,1),MP(:,2),'kx','LineWidth',2)
hold off
legend('Cluster 1','Cluster 2','Cluster 3')
title('GM toy data')


X = [X1;X2;X3]; % shuffle the data source
figure(2)
scatter(X(:,1),X(:,2),10,'filled')
title('GM toy data')

end