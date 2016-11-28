function H = entropy_mle(p)
% function H = entropy_mle(p)
%   p   vector with observed frequencies of all words
%   H   ML estimate of entropy
N = sum(p);
p1 = p(p ~= 0);
H= -(1/N)*(sum(p1.*log2(p1))) + (1/N)*sum(p1.*log2(N));
