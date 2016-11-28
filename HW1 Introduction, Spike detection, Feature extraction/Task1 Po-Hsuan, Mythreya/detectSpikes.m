function [s, t] = detectSpikes(x, Fs)
% Detect spikes.
%   [s, t] = detectSpikes(x, Fs) detects spikes in x, where Fs the sampling
%   rate (in Hz). The outputs s and t are column vectors of spike times in
%   samples and ms, respectively. By convention the time of the zeroth
%   sample is 0 ms.
%% Example
% Raw = y;
%Fs = samplingRate;
%%
Raw = x;
Ts= 1/Fs;               % Sample Time
Len = length(Raw(:,1)); % Length of Singal
n = 1;                  % segment percentile
Seg = 1:Len*n; 
Raw = Raw(Seg,:);
time=  Seg.*Ts*10e3 ;         % Time vector (ms)
Th = 4*median(abs(Raw)/0.6745);

%%
 s=NaN(1e6,4); 
 t=NaN(1e6,4);
 p=NaN(1e6,4);
 
for i = 1:4;
[Pks,Loc]=findpeaks(Raw(:,i),'MinPeakHeight',Th(i));
    if length(Loc)>= 100 && length(Loc)<= 1e6
     s(1:length(Loc),i)=Loc';                            % sample indices
     p(1:length(Pks),i)=Pks;
    % SPIKE TRAIN
    %       t_binary(:,i)= zeros(length(time),1); 
    %       t_binary(s(not(isnan(s(:,i))),i),i)=1;           % spike train

    le= length(time(s(not(isnan(s(:,i))),i))');
    t(1:le,i) = time(s(not(isnan(s(:,i))),i))';
    elseif length(Loc)<= 100
        fprintf('the number of detected spikes is smaller than 100. Try larger data set.');break
    elseif length(Loc)>= 1e6
        fprintf('the number of detected spikes is larger than 1e6, try smaller data set.'); break
    end    
end

%% Quick Result Monitor
% figure(2)
% for i=1:4
% subplot(4,1,i)
% plot(time,Raw,'b',t(:,i),p(:,i),'rO',time,Th(i)*ones(1,length(time)),'g-');
% hold on
% xlabel('time (ms)')
% ylabel('voltage (uV)')
% end
% %% Spike train
% figure(3)
% strips(t_binary);
% xlabel('sample')
% ylabel('channel')
% title('Spike Train')
end
