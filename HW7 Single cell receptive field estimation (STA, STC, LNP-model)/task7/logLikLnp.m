function [f ,df] = logLikLnp(rf,sp,stim,option)
% rf = rand(225,1);
% rf = zeros(225,1);
% k = 100;
% sp = c(1,1:k);
% stim = s(:,1:k);
%%
% [f df] = logLikLnp(x,c,s)
%   Implements the negative (!) log-likelihood of the LNP model and its
%   gradient with respect to the receptive field w.
%
%   x   current receptive field (225 x 1)
%   c   spike counts (1 x T/dt)
%   s   stimulus matrix (225 x T/dt)
%
%   f   function value of the negative log likelihood at x (scalar)
%   df  gradient of the negative log likelihood with respect to x (225 x 1)
%
% PHB 2012-06-25

option = 2;

switch option 
    
case  1
%%  Slow method

    r = exp(rf'*stim) ;  % 1 :T/dt 
    c = poissrnd(r)   ;  % 1:T/dt
    c = sp            ;  
    %Poiss(1,t) = r(1,t).^sp(t) ./factorial(sp(t)) .* exp(-r(1,t));  % 225 X t
    Poiss = poisspdf(c,r);
    
    Like = prod(Poiss,2);   %  125
    neglogL = -log(Like);
   
    f = neglogL;
   
%% Do the differentiation

    dw = 1e-13 ; 

    for i= 1: 225 
    
    diff   =  zeros(225,1)  ;
    diff(i)   =  dw;
       
    rf2 = rf + diff ;

    r = exp(rf2'*stim) ;  % 1 :T/dt 
    c= poissrnd(r);      % 1:T/dt
    
    %Poiss(1,t) = r(1,t).^sp(t) ./factorial(sp(t)) .* exp(-r(1,t));  % 225 X t
    Poiss2 = poisspdf(c,r);
    
    Like2 = prod(Poiss2,2);   %  125
    neglogL2 = -log(Like2);

    df(i) = (neglogL2 - neglogL) / dw ;

    end
    df= df';
    

    
case 2
    
    
    
%% Fast method


     r = exp(rf'*stim); % 1 X T
     %c = poissrnd(r);% 1 X T
     c= sp;
     f = - sum(c.*(rf'*stim)-r,2);
    df = -(c*stim' - r*stim');
    df = df';
end
