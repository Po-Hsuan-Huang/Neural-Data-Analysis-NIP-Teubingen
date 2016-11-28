function params = fitLS(dirs, counts)
% Fit parametric tuning curve using least squares.
%   params = fitLS(dirs, counts) fits a parametric tuning curve using least
%   squares and returns the fitted parameters. 
%
%   Inputs:
%       counts      matrix of spike counts as returned by getSpikeCounts.
%       dirs        vector of directions (#directions x 1)

%syms alpha k v phi theta;
%syms p theta;
%f = symfun( exp( alpha + k * cos(2 * (theta-phi) - 1) + v * cos( (theta-phi) - 1)),[alpha,k,v,phi, theta]);

p0 = [1,1,1,0];
s = tuningCurve(p0,dirs);
%f(p,theta) =  exp( p(1) + p(2) * cos(2 * (theta-p(4)) - 1) + p(3) * cos( (theta-p(4)) - 1));
%x0 = [1,1,1,0];


params = lsqcurvefit(@tuningCurve,p0,dirs,counts');
fitted = tuningCurve(params,dirs);
% Get the output for LS params


     
      