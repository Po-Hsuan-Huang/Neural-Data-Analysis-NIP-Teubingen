function y = filterSignal_with_plot(x, Fs)
% Filter raw signal
% y = filterSignal(x, Fs) filters the signal x. Each column in x is one
% recording channel. Fs is the sampling frequency. The filter delay is
% compensated in the output y.
% segmenting raw data
%% Example
% filterSignal('NDA_rawdata.mat',30e3 )
% load('NDA_rawdata.mat')
% Fs = 30e3;                        %Sampling frequency



%% Raw data recording in total. 
Raw = double(x);
Len = length(Raw(:,1)); % Length of Singal
Ts= 1/Fs;             % Sample Time



n = 0.1;         % segment percnetile
Seg = 1:Len*n; 
Raw = Raw(Seg,:);



%% Filter
Nyquist = Fs/2;
[b,a] = butter(2,[500/Nyquist,(2e3-1)/Nyquist]);
[y] = filtfilt(b,a,Raw);   % Zero-phase filtering helps preserve features
time =  Seg.*Ts ;         % Time vector

%% Quick Result MOnitor
for i = 1:4
figure(1)
subplot(4,1,i)
plot(time,x(Seg,i),'b');
hold on
plot(time,y(:,i),'r');
xlabel('time(s)')
ylabel('voltage(uV)')
end
end
