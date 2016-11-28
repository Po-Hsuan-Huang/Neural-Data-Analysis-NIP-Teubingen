function BIC=Complexity_critiria(mu,sigma,priors)

options = statset('Display','final'); 

for i = 1:10
    
    gm = fitgmdist(X,i,'Options',options,'Regularize',0.1);
    
    [P,logL] = posterior(gm,X);
    bic = 2*logL +100* i* log(size(X,1));
    %[aic,bic] = aicbic(-logL,i,size(X,1));
    %[aic2,bic2] = aicbic(logL,i,X(:,2));
    BIC(1,i) = bic;
end
 figure(4)
 xlabel('Num of Components');
 ylabel('BIC');
 plot(BIC)