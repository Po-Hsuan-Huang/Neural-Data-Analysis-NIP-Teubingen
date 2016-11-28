%% Task4 result
% Baseline with the most simple algorithm: ~0.32 (0.00-0.54)


ans = open('TrainingData.mat');
Data= ans.data;
clear ans;

for i  =1 :10
    
inferredRate{i} = estimateRateFromCa(Data(i).GalvoTraces,Data(i).fps);
label{i} = Data(i).SpikeTraces;

RHO = corrcoef(label{i},inferredRate{i}); % correlatoin between label and estimation.
Corrcoef(i)= RHO(1,2);
end

