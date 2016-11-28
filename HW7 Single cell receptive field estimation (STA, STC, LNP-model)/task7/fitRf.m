function [rf,iter] = fitRf(sp,stim,tsteps)

% rf = fitRf(sp,stim)
%   estimate the linear receptive field rf from the binned spike train sp 
%   and the stimulus stim for an LNP neuron with exponential nonlinearity.
%
%   sp: 1 x ceil(T/dt)          vector of spike counts in time bins of width dt
%
%   stim: 225 x ceil(T/dt)      matrix with +1/-1 entries indicating which
%                               pixels of the stimulus were brighter or less 
%                               bright than the background in each time frame
%
%   tsteps: scalar              specifies number of timesteps into the past
%
%   rf: 225 x tsteps            matrix containing the receptive field of the neuron
%                               at tsteps time lags of size dt
%
% PHB 2012-06-21

rf0 = rand(225*tsteps,1);
rf0 = zeros(225*tsteps,1);


for i = 1 : tsteps-1
 stim= [stim;circshift(stim(1:225,:),i,2)]  ; 
end

 stim= stim(:,tsteps:end);
 sp= sp(tsteps:end);

%[f , df] = logLikLnp(rf0,sp,stim);

 len = 1000;  % max iterations

[rf,fx,iter] = minimize(rf0,@logLikLnp,len,sp,stim);

 rf = reshape(rf,225,[]);
 
end





