function [logLike, gradient] = poissonNegLogLike(p, counts, theta)
% Negative log likelihood for Poisson spike count and von Mises tuning.
%   [logLike, gradient] = poissonNegLogLike(p, counts, theta) returns the
%   log-likelihood (and its gradient) of the von Mises model with Poisson
%   spike counts.
%
%   Inputs:
%       p           four-element vector of tuning parameters
%       counts      column vector of spike counts
%       theta       column vector of directions of motion (same size as
%                   spike counts)
%
%   Outputs:
%       logLike     negative log-likelihood
%       gradient    gradient of negative log-likelihood with respect to 
%                   tuning parameters (four-element column vector)
 

%  theta  = dirs;
%  counts = Mcountcell(2,:);
%  p = fitLS(dirs, counts);  % starting point 
%  p = p';
%p = [3 2 2 30];

%% teachers comment, you shouldnt feed mean firing rate in, but the total firing count,
% so that you dont need to round anything.



y = tuningCurve(p, theta) ; % von Mises curve fitting model

for i = 1 : length(y)

pdf(1,i) = poisspdf(round (counts(i) ) ,y(i));  % the funciton returns 0 when counts is not integer

end

LH = prod(pdf,2); % likelihood distribution over x = 1:100

logLike= -log(LH);




%% gradient wrt alpha 

eps = 1e-13;

for k = 1 : length(p) % k=  1:4 corresponds to alpha kappa, nu, phi
    
diff = [0 ;0; 0; 0 ];
        
diff(k) = eps ; 

y2 =  tuningCurve(p + diff, theta);

for i = 1 : length(y)   % for each direction

pdf(:,i) = poisspdf(round(counts(i)),y2(i));

end

LH2 = prod(pdf,2); % likelihood

logLike2= -log(LH2);

gradient(k,1) = (logLike2 -logLike )/eps ; 

end


