function [Ratio,fit_psth]=linearityIndex(psth,fs,range)

% psth signal      1xd vector
% fs               sampling frequency a number
% range            inquired power band range in 1x2 double 
Intensity =bandpower(psth,fs,range);
base      =bandpower(psth,fs,[0 0.001]);
Ratio = Intensity/base;
Edge = 0:1000/fs:2000;
fit_psth = fit(Edge', (psth-mean(psth)),'sin1');

hold off