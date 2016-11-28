function H = entropy_cae(p)

% function H = entropy_cae(p)
%   p   vector with observed frequencies of all words
%   H   coverage adjusted estimate of entropy
N = sum(p);
p = p(p ~= 0);
C = 1 - sum(p==1)/N;
p = p*C;
H= (1/N)*(sum(p.*(log2(p)-log2(N))./(1-(1-p/N).^N)));
H = -H;