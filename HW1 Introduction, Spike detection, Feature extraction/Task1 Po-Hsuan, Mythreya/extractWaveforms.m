function w = extractWaveforms(x, s)
% Extract spike waveforms.
%   w = extractWaveforms(x, s) extracts the waveforms at times s (given in
%   samples) from the filtered signal x using a fixed window around the
%   times of the spikes. The return value w is a 3d array of size
%   length(window) x #spikes x #channels.

y=x;
Fs= 30e3;


%%
% one waveform window is 1ms
Window_width= floor(Fs*1e-3);
% peak locates at 0.3 ms of the window 
Window_shift= floor(Fs*0.3e-3);

for i = 1:4
    location=  s(not(isnan(s(:,i))),i);
    Peak_sort= sort(y(location,i),'descend');
    Peak_100 = Peak_sort(1:100); 
      for index= 1:100
       loc(index,i)= find(y(:,i)==Peak_100(index));
       % largest 100
       Waveform(:,index,i) = y(loc(index,i)-Window_shift: loc(index,i)-Window_shift+Window_width,i);
       % first 100
       Waveform_first(:,index,i)= y(location(index)-Window_shift: location(index)-Window_shift+Window_width,i);
      end
end
 w= Waveform;

%% Quick Result Monitor
% figure(4)
% 
% for i = 1:4
% subplot(2,2,i)
% plot(Waveform(:,:,i));
% 
% title(sprintf('Largest 100 \n channel %d',i));
% 
% end
% 
% figure(5)
% for i = 1:4
% subplot(2,2,i)
% plot(Waveform_first(:,:,i));
% 
% title(sprintf('First 100 \n channel %d',i));
% 
% end

end
