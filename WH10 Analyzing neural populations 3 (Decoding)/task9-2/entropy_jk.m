function H = entropy_jk(p)
% function H = entropy_jk(p)
%   p   vector with observed frequencies of all words
%   H   jackknife estimate of entropy

% jack-knifed entropy estimator (paninski, p. 1198)
sampHist = accumarray(p',1);
N = sum(sampHist);


for i = 1: length(p)
 q = p; 
 q=[q(1:i-1),q(i+1:end)];
 qHist = accumarray(q',1); 
 n = sum(qHist);
 qHist=qHist(qHist~=0);
 H_i(i)= -(1/n)*(sum(qHist.*log2(qHist))) + (1/n)*sum(qHist.*log2(n));
end

H_bias=mean(H_i);
sampHist = sampHist(sampHist~=0);
H= -sum(sampHist.*log2(sampHist)) + sum(sampHist*log2(N)) - (N-1)*H_bias;
