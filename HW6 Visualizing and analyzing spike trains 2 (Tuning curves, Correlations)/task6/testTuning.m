function [p, q, qdistr] = testTuning(dirs, counts)
% Test significance of orientation tuning by permutation test.
%   [p, q, qdistr] = testTuning(dirs, counts) computes a p-value for
%   orientation tuning by running a permutation test on the second Fourier
%   component.
%
%   Inputs:
%       counts      matrix of spike counts as returned by getSpikeCounts.
%       dirs        vector of directions (#directions x 1)
%
%   Outputs:
%       p           p-value
%       q           magnitude of second Fourier component
%       qdistr      sampling distribution of |q| under the null hypothesis
         [f,q0] = fitCos(dirs, counts);


for j = 1: 16   % # trails

         M_plot(j) = mean(counts(j,11*(j-1)+1:11*j)) ; 
         V_plot(j) = (var(counts(j,11*(j-1)+1:11*j)))^(1/2) ; 

end


for k = 1:1000

    ind(:,k) = randperm(176); 
    
    CRP = counts(:,ind(:,k));  % counts of random permutation
   
    [f,qu] = fitCos(dirs, CRP);
    
    Q(k) = abs(qu);
    
    t(k)= mean(f)/(var(f))^(1/2);
    

end

  
  
  h = histogram(Q,100);
  
  h.FaceColor  =  'none' ; 
  h.EdgeColor = 'none' ; 
  q = h.Values;
  
  qdistr = h.BinEdges ;  
    
  ind = qdistr >= abs(q0) ;
          
  p = sum (q( ind(1:end-1)))/sum(q);
         
    
    