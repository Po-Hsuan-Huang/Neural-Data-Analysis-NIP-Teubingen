function [f,q] = fitCos(dirs, counts)
% Fit cosine tuning curve.
%   f = fitCos(dirs, counts) fits a cosine tuning curve by projecting on
%   the second Fourier component. Returns f, a vector of estimated spike
%   counts given the cosine tuning curve.
%
%   Inputs:
%       counts  matrix of spike counts as returned by getSpikeCounts.
%       dirs    vector of directions (#directions x 1)

for j = 1: 16   % # trails

         M(j) = mean(counts(j,11*(j-1)+1:11*j)) ; 
         V(j) = 1/4 * exp(2i*( dirs(j)/180) * pi);
end

%% Tuning curve
         q  = M*V.' ;  %% the ' also does the complex conjugate thing, use .' to do nonconjugated transpose
         
         f  = mean(M) + conj(V)*q + V*conj(q);
%end

