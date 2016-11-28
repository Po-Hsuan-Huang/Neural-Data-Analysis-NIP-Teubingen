%% Neural Data Analysis 
% Task4 Spike inference from Ca traces
% Due date: 14 of July!
% Baseline with the most simple algorithm: ~0.32 (0.00-0.54)

%% Plain peakfind and cross corr measure
% Subthreshold filtering and exponential rate detection tuning
% this version is modified file of CaTraceMythreya.m by Po-Hsuan. 


ans = open('TrainingData.mat');
Data= ans.data;
clear ans;
%%
%  create a function inferredRate = estimateRateFromCa(trace)
%  trace ... Calcium trace
%  inferredRate... Inferred Spiking Rate
%   Corrcoef ...corelation coefficient.
  
  n_frame =length(Data(1).GalvoTraces); % number of frames
  Ca_sig = double(Data(1).GalvoTraces);
  label= Data(1).SpikeTraces;
  rate = Data(1).fps;     % sampling rate
  tSam = n_frame/rate;    % sampling time
  time = linspace(0,tSam,n_frame);
  refspiketrain = zeros(length(Data(1).SpikeTraces),1);
  
  
   
 figure(1)
  subplot(2,1,1)
    plot(time, Data(1).GalvoTraces);
  subplot(2,1,2)
    plot(time, Data(1).SpikeTraces);
  
    
% Low Pass Filter
Nyquist = rate/2;
[b,a] = butter(2,[0.01/Nyquist, 0.2/Nyquist]);
Ca_filt = filtfilt(b,a,Ca_sig);   % Zero-phase filtering helps preserve features

    % 
    % figure(2)
    % subplot(3,1,1);
    % plot(time,Ca_sig);
    % subplot(3,1,2);
    % plot(time,Ca_filt);
    % subplot(3,1,3);
    % plot(time,Data(1).SpikeTraces);
  

% %% only use 10% of data
% i = 1;
% Ts= 1/rate;               % Sample Time
% Len = length(Ca_filt); % Length of Singal
% n = 0.1;               % segment percentile
% Seg = 1:Len*n; 
% time=  Seg*Ts ;         % Time vector (ms)
% Th(i) = 1*median(abs(Ca_filt)/0.6745);
% Ca_filt_seg= Ca_filt(length(Ca_filt)*n+1:2*length(Ca_filt)*n);

%% Peak detection with unfiltered Ca trace

Th = 1*median(abs(Ca_sig)/0.6745);

[Pks,Loc]=findpeaks(Ca_sig,'MinPeakHeight',Th);
 s=Loc';                            % sample indices
 p=Pks;      
% SPIKE TRAIN
      t_binary = zeros(length(time),1); 
      t_binary(s)=1;                             
      t = time(s)';               % spike train



    % figure(3)
    % subplot(3,1,1)
    % plot(time,Ca_sig,'b',t,p,'r.',time,Th*ones(1,length(time)),'g-');
    % hold on
    % xlabel('time (s)')
    % ylabel('voltage (uV)')
    % hold off
    % 
    % % Spike train
    % subplot(3,1,2)
    % plot(time,t_binary);
    % xlabel('time (s)')
    % ylabel('channel')
    % title('Spike Train')
    % 
    % subplot(3,1,3);
    % plot(time,refspiketrain);

corr = xcorr(refspiketrain,t_binary);
zero_lag_corr = corr(length(refspiketrain));
corrsum = sum(corr);


%% Find peaks and cross corr for the filtered Ca tracing


 Th = 0.5*median(abs(Ca_filt)/0.6745);

 [Pks,Loc]=findpeaks(Ca_filt,'MinPeakHeight',Th);
  s=Loc';                            % sample indices
  p=Pks;      
% SPIKE TRAIN
      t_binary = zeros(length(time),1); 
      t_binary(s)=1;                             
      t = time(s)';               % spike train



    % figure(4)
    % subplot(3,1,1)
    % plot(time,Ca_filt,'b',t,p,'r.',time,Th*ones(1,length(time)),'g-');
    % hold on
    % xlabel('time (s)')
    % ylabel('voltage (uV)')
    % hold off
    % 
    % % Spike train
    % subplot(3,1,2)
    % plot(time,t_binary);
    % xlabel('time (s)')
    % ylabel('channel')
    % title('Spike Train')
    % 
    % subplot(3,1,3);
    % plot(time,refspiketrain);

[corrfilt,lags] = xcorr(refspiketrain,t_binary);
zero_lag_corr_filt = corrfilt(length(refspiketrain));
corrsumfilt = sum(corrfilt);




%% Find the filter threshold and decay constant for decon that maximizes the cross corr

% Take exponential kernel

tau = linspace(0.1,5.5,100); % time constant

for i = 1:length(tau)
time= 0:1/rate:0.3*tau(i);

k = 0.1*exp(-(time)/tau(i));

[decontrace{i},r] = deconv(Ca_filt',k);

if length(decontrace{i}) <= n_frame
    null = zeros(1, n_frame);
    null(1,1:length(decontrace{i}))= decontrace{i} ;
    deconSpikes(:,i) = null ; 
end

[corrfilt,lags] = xcorr(deconSpikes(:,i),label);
zero_lag_corr_filt_decon(i) = corrfilt(length(refspiketrain));
corrsumfilt = sum(corrfilt);

end


% find decay const that maximizes the correlation
[v,ind]=sort(zero_lag_corr_filt_decon, 'descend');
optdecayinsec = tau(ind(1));


% u = [1   2   3   4]
% v = [10   20   30]
% 
% c = conv(u,v);
% 
% q = deconv(c,u)


deconSpikes(deconSpikes(:,ind(1))< 0,ind(1))=0;

norm = max(label)/max(deconSpikes(:,ind(1)));
rescaled_sig = norm.*deconSpikes(:,ind(1));

figure(2); 
subplot(3,1,1) ;plot(Ca_filt); 
subplot(3,1,2); plot(Data(1).SpikeTraces);
subplot(3,1,3) ;plot(rescaled_sig);

RHO = corrcoef(label,rescaled_sig); % correlatoin between label and estimation.
Corrcoef= RHO(1,2);
inferredRate = deconSpikes(:,ind(1));
