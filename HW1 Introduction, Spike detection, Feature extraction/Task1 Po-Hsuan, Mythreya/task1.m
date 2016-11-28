% prepare data
load NDA_rawdata
x  = gain * double(x);

% run code
y = filterSignal(x,samplingRate);
[s, t] = detectSpikes(y,samplingRate);
w = extractWaveforms(y,s);
b = extractFeatures(w);

decision= input('Do you want to plot ? y/n \n','s');

if decision =='y'
%% plot figures
fprintf('please wait....\n');

y = filterSignal_with_plot(x,samplingRate);
[s, t] = detectSpikes_with_plot(y,samplingRate);
w = extractWaveforms_with_plot(y,s);
b = extractFeatures_with_plot(w);
else
    break
end