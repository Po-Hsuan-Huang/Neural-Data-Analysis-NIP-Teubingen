function [params,p,iter] = fitML(dirs, counts)
% Fit tuning curve using maximum likelihood and Poisson noise model.
%   params = fitML(dirs, counts) fits a parametric tuning curve using
%   maximum liklihood and a Poisson noise model and returns the fitted
%   parameters.
%
%   Inputs:
%       counts      matrix of spike counts as returned by getSpikeCounts.
%       dirs        vector of directions (#directions x 1)

 p = fitLS(dirs, counts);  % starting point 
 
 %p = abs( randn(1,4) );
 
 len = 100;  % max iterations
 
 
% [logLike, gradient] = poissonNegLogLike(params, counts, dirs);
%f2 = @(p) poissonNegLogLike(p',counts,dirs);
%[params,fx,iter]  = minimize(p',f2 , len, counts, dirs);

[params,fx,iter]  = minimize(p',@poissonNegLogLike, len, counts, dirs);
