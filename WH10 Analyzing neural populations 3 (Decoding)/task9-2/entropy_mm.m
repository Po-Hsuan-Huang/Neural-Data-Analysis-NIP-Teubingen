function H = entropy_mm(p)
% function H = entropy_mle(p)
%   p   vector with observed frequencies of all words
%   H   ML estimate of entropy with miller-maddow correction

N = sum(p);
p1 = p(p ~= 0);
H_ml= -(1/N)*(sum(p1.*log2(p1))) + (1/N)*sum(p1.*log2(N));  %entropy fo maxlike.

d = sum( p>0 );

H = H_ml + (d-1)/(2*N);
