figure()
t = linspace(0,2*pi,100);
plot(t,sin(t));
a=1;
cb=2;
string = sprintf('cluster %d , cluster %d',a,cb);
title(string);