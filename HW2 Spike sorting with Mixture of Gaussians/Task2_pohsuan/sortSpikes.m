function [mu, Sigma, priors, df, assignments] = sortSpikes(b)
% Do spike sorting by fitting a Gaussian or Student's t mixture model.
%   [mu, Sigma, priors, df, assignments] = sortSpikes(b) fits a mixture
%   model using the features in b, which is a matrix of size #spikes x
%   #features. The df output indicates the type of model (Gaussian: df =
%   inf, t: df < inf)
%
%   The outputs are (K = #components, D = #dimensions):
%       mu              cluster means (K-by-D)
%       Sigma           cluster covariances (D-by-D-by-K)
%       priors          cluster priors (1-by-K)
%       df              degrees of freedom in the model (Gaussian: inf)
%       assignments     cluster index for each spike (1 to K)
X=b;
%X=cat(2,b(:,1),b(:,4));


df = inf;   % you don't need to use this variable unless you want to 
            % implement a mixture of t-distributions
num= size(b,1);            
NC = 3;    
s =num.*(bsxfun(@times,1/NC, 1:NC));
s=round(s);
mu1=mean(X(1:s(1),:));
sigma1 = 100.*cov(X(1:s(1),:));
mu2=mean(X(s(1)+1:s(2),:));
sigma2 = 100.*cov(X(s(1)+1:s(2),:));
mu3=mean(X(s(2)+1:s(3),:));
sigma3 = 100.*cov(X(s(2)+1:s(3),:));


mu(:,:)=[mu1;mu2;mu3];
sig = {sigma1, sigma2,sigma3} ;
wei= (bsxfun(@times,1/NC, ones(1,NC)));

for iter = 1:120 %% EM iteration cycles

% Expectation step
    
    
    for j = 1:NC % number of cluster
            
          %M = bsxfun(@times,mu(j,:), ones(length(X(:,1)),2));
        for k = 1:num
          F(k,j) = wei(j)*(sqrt((2*pi)^2*abs(det(sig{j}))))^-1*exp(-0.5*(X(k,:)-mu(j,:))*inv(sig{j})*(X(k,:)-mu(j,:))');
    
        end
    end
    for j = 1:NC
     Z= sum(F,2);
     R(:,j) = F(:,j)./Z;   %% rik responsibility: how much percentage of data point i is k mode responsible for
     
    end
     G = sum(R,1);       %%  how much percentage of data is K mode responsible for 

% Maximization step


for j = 1:NC
wei(j) = G(j)/(num);

mu(j,:) = sum(bsxfun(@times,R(:,j), ones(1,2))'* X,1)./G(j);

         for k = 1:length(X(:,1))
           E(:,:,j,k) =  R(k,j).*(X(k,:)-mu(j,:))'*(X(k,:)-mu(j,:))./G(j);
         end
          sig{j}= sum( E(:,:,j,:),4) ;
end
end


%% max a-posteriori predictive labeling

for i = 1: num
    
    
    idx(i) = find(R(i,:)==max(R(i,:)))';
end




% yild function output
cluster1 = (idx == 1)';
cluster2 = (idx == 2)';
cluster3 = (idx == 3)';

mu(1,:)=mean(X(cluster1,:));
Sigma(:,:,1)=cov(X(cluster1,:));

mu(2,:)=mean(X(cluster2,:));
Sigma(:,:,2)=cov(X(cluster2,:));

mu(3,:)=mean(X(cluster3,:));
Sigma(:,:,3)=cov(X(cluster3));

priors = G;

assignments=idx;
%%
figure(2)
scatter(X(cluster1,1),X(cluster1,2),10,'r+');
hold on
scatter(X(cluster2,1),X(cluster2,2),10,'bx');
scatter(X(cluster3,1),X(cluster3,2),10,'go');

hold off
legend('Cluster 1','Cluster 2','Cluster 3','Location','NW')
title('GM cluster fit')

%specify correct clustering number.

V=perms(1:3);
for i =1:length(V)
idx_true(:,i)=[V(i,1)*ones(300,1);V(i,2)*ones(500,1);V(i,3)*ones(200,1)];
end
idx_m=bsxfun(@times, idx', ones(1,size(V,1)));
Mis= min(sum(not(idx_true==idx_m))); % misclassification
