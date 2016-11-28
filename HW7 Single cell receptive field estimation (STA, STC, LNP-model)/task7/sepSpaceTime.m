function [ws wt s] = sepSpaceTime(w,i)

% [ws wt] = sepSpaceTime(w)
%   Apply SVD to recover the space and time kernels of the space-time
%   separable recpetive field w.
%
%   w   receptive field (225 x timeSteps)
%   i   returns i th component
%   ws  spatial component of the receptive field (225 x 1)
%   wt  temporal component of the receptive field (timeSteps x 1)
%
%   PHB 2012-06-25


  [U,S,V]=svd(w);   
  
ws = U(:,i);
wt = V(:,i);

%s = (diag(S))
s = S;
figure()
plot(1:length(diag(s)),diag(s))

