
%% Task 7.1: fit instantaneous receptive field

% parameter settings
par.T = 200000;                     % duration of experiment in ms
par.dt = 20;                        % bin width in ms
par.gabor = [0.2 0.05 .3 pi/2];     % settings for spatial rf (gabor)
par.temp = [NaN NaN NaN 1];         % settings for temporal kernel (raised cosine)
par.stimtype = 'gaussian';
par.nonlin = 'exp';

% get spike counts
[c s w_true] = sampleLnp(par);

% c ... spike train 1 x T/dt
% s ... stimulus 225 xT/dt

%%
% fit receptive field
[w_est,iter]= fitRf(c,s,1);   

% visualize true and estimated receptive field (on same scale)

% ADD YOUR CODE HERE ....

%%
figure(1)
clf
subplot(1,2,1)
 C1= reshape(w_true,15,15);
 imagesc(C1);
cmin= min(w_true);
cmax= max(w_true);

% surface(C1);
 title('true receptive field')

subplot(1,2,2)
 C2= reshape(w_est,15,15);
 imagesc(C2);
 %surface(C2);
 title('estimated receptive field')




%% Task 7.2: fit spatio-temporal receptive field

order = 10;

par.temp = [1 0.1 pi/2 order];

% get spike counts
[c s w_true2] = sampleLnp(par);
w_true2 = reshape(w_true2,225,[]);

% fit receptive field
 [w_est2,iter2] = fitRf(c,s,order);

% visualize true and estimated receptive field (on same scale) for the
% different time bins

% ADD YOUR CODE HERE ....
%%
figure(2)
clf
cmin = min(min(w_true2));
cmax = max(max(w_true2));
for i  = 1 :order
subplot(2,10,i)
 C1= reshape(w_true2(:,i),15,15);
 imagesc(C1);
  caxis([cmin cmax]);

 str = sprintf(' RF_true of -%d dt', i);
 title(str)
end

cmin = min(min(w_true2));
cmax = max(max(w_true2));

for i = 1:order
subplot(2,10,order + i)
 C2= reshape(w_est2(:,i),15,15);
 imagesc(C2);
 caxis([cmin cmax]);
 
 str = sprintf(' RF_est of -%d dt', i);
 title(str);

end


%% Task 7.3: recover space and time kernels

% space-time separation of true receptive field
[ws wt s] = sepSpaceTime(w_true2,1);

[ws_est wt_est s_est] = sepSpaceTime(w_est2,1);

% visualize true and estimated spatial receptive field (on same scale) and
% the true and estimated time kernels

% ADD YOUR CODE HERE ....

% it is possible that SVD inverts the temporal component
% if the peak points downward, flip sign as needed:
wt_est = wt_est * sign(mean(wt_est));


figure(3)
clf
subplot(1,2,1)
 C1= reshape(ws,15,15);
 imagesc(C1);

% surface(C1);
 title('True receptive field', 'FontSize',16)

subplot(1,2,2)
 C2= reshape(ws_est,15,15);
 imagesc(C2);
% surface(C2);
 title('Spatial component of estimated receptive field', 'FontSize',16)
 %%
 figure(5)
 clf 
 plot(1:length(wt),wt,'r',1:length(wt),wt_est,'b');
 legend('true','estimate')
 xlabel('Time steps') 
 ylabel('weight')
 title('Temperal component of receptive field', 'FontSize',16)
 %%
 figure(6)
 clf
 diag(s)
 %semilogy(1:length(diag(s)),diag(s),'-o');
 plot(1:length(diag(s)),diag(s),'-o');
 hold on
 %semilogy(1:length(diag(s_est)),diag(s_est),'-o');
 plot(1:length(diag(s_est)),diag(s_est),'-o')
 hold off
 lg  =legend('true','estimate')
lg.FontSize=18
 title('Single Values of the Receptive Field', 'FontSize',16)
 







%% task 7.4: fit spatio-temporal receptive field to data

data = load('rf_data.mat');

c1 = data.spk;
s1 = data.stim;
%%
% fit receptive field

figure(4)
clf
for shift = 3 : 10;
    w_est = fitRf(c1(shift:end),s1(:,1:end-shift+1),1);
    subplot(1,8, shift-2)
    imagesc(reshape(w_est, 15, 15))
    str = sprintf(' %d ms ', 10* (shift-1));
    title(str)
end

   a=suptitle('recpetive field lag response');
    
   a.FontSize = 24;
    
    
    
   %% 
   %% Task 7.5: recover space and time kernels

% space-time separation of true receptive field


% fit receptive field

[w_real,iter2] = fitRf(c1,s1,order);
%%
for i = 1:10
[ws_real(:,i) wt_real(:,i) s_real] = sepSpaceTime(w_real,i);
end
% visualize true and estimated spatial receptive field (on same scale) and
% the true and estimated time kernels

% ADD YOUR CODE HERE ....

% it is possible that SVD inverts the temporal component
% if the peak points downward, flip sign as needed:


wt_real = wt_real * sign(mean(wt_real));
%%
cmin = min(min(ws_real));
cmax = max(max(ws_real));
figure(8)
clf

 C2= reshape(ws_real,15,15,[]);
 for i = 1:10
  subplot(1,10,i)
 imagesc(C2(:,:,i));
 caxis([cmin cmax]);

% surface(C2);
str = sprintf('  %d th component ',i);
 title(str);
 end
 sup=suptitle('Spatial component of real receptive field')
 sup.FontSize = 24;
 %%
 figure(9)
 clf 
 plot(1:length(wt),wt_real,'b');
 xlabel('Time steps') 
 ylabel('weight')
 title('Temperal component of real receptive field', 'FontSize',16)
    
    
 figure(10)
 clf
 %semilogy(1:length(diag(s)),diag(s),'-o');
 plot(1:length(diag(s_real)),diag(s_real),'-o');
 
lg.FontSize=18
 title('Single Values of the Real Receptive Field', 'FontSize',16)
 
  
    
    