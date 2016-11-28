function b = extractFeatures(w)
% Extract features for spike sorting.
%   b = extractFeatures(w) extracts features for spike sorting from the
%   waveforms in w, which is a 3d array of size length(window) x #spikes x
%   #channels. The output b is a matrix of size #spikes x #features.
%
%   This implementation does PCA on the waveforms of each channel
%   separately and uses the first three principal components. Thus, we get
%   a total of 12 features.

%%
% Find the first 3 principle components of w using SVD

for i = 1:4
b(:,:,i) = pca(w(:,:,i), 'NumComponents', 3);

%% Lets try k means clustering to see if there are spikes from 2 neurons
for j= 1:3

[idx,ctrs] = kmeans(b(:,:,i),2,...
                    'Distance','sqEuclidean');
  
                
% Plot clusters
% figure(i)
% 
% 
% subplot(2,2,j)
% scatter3(b(idx==1,1,i),b(idx==1,2,i),b(idx==1,3,i),'ro')
% hold on
% scatter3(b(idx==2,1,i),b(idx==2,2,i),b(idx==2,3,i),'bx')
% 
% scatter3(ctrs(:,1),ctrs(:,2),ctrs(:,3),'kx',...
%      'LineWidth',2)
%    hold off
% title(sprintf('PCA channel %d ', i))
% xlabel('cmp1');
% ylabel('cmp2');
% zlabel('cmp3');
% angle= [0 0 0];
% angle(j)=1;
% view(angle);
end
%%




end
% figure(6)
% subplot(2,3,1)
% scatter(b(:,1,1),b(:,1,2));
% xlabel('ch1')
% ylabel('ch2')
% subplot(2,3,2)
% scatter(b(:,1,1),b(:,1,3));
% xlabel('ch1')
% ylabel('ch3')
% subplot(2,3,3)
% scatter(b(:,1,1),b(:,1,4));
% xlabel('ch1')
% ylabel('ch4')
% 
% subplot(2,3,4)
% scatter(b(:,1,2),b(:,1,3));
% xlabel('ch2')
% ylabel('ch3')
% subplot(2,3,5)
% scatter(b(:,1,2),b(:,1,4));
% xlabel('ch2')
% ylabel('ch4')
% subplot(2,3,6)
% scatter(b(:,1,3),b(:,1,4));
% xlabel('ch3')
% ylabel('ch4')
% 

end
