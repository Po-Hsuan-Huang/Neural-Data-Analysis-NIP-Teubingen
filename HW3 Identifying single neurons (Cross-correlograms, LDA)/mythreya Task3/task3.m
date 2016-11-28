% load data from task 2
load NDA_task1_results
load NDA_task2_results
%%
% diagnostic plots
clf
plotWaveforms(w, assignments)
%%
plotCCG(t, assignments)
%%
channels=[1,7];
clf;
clusters = '123456789';
plotClusters(b,assignments,clusters, channels)
%%
plotSeparation(b, mu, Sigma, priors, assignments)
