function y = tuningCurve(p, theta1)
% Evaluate tuning curve.
%   y = tuningCurve(p, theta) evaluates the parametric tuning curve at
%   directions theta (in degrees, 0..360). The parameters are specified by
%   a 1-by-k vector p.

% Von mises function

%%

%syms alpha k v phi theta;
y = (( exp( p(1) + p(2) * cos(2 * (theta1-p(4))*pi/180 - 1) + p(3) * cos( (theta1-p(4))*pi/180 - 1))));

%y = eval(f(p(1),p(2),p(3),p(4),theta1));


% %%
% syms alpha k v phi theta;
% f = symfun( exp( alpha + k * cos(2 * (theta-phi) - 1) + v * cos( (theta-phi) - 1)),[alpha,k,v,phi, theta]);
% 
% s = eval(f(1,1,1,0,[0:0.1:2*pi]))
% 
% %%
% 
% s = eval(f(1,1,1,0,[0:0.1:2*pi]))
% 
% figure(200)
% angle = [0:0.1:2*pi];
% subplot(4,1,1)
% 
% s = eval(f(1,1,1,0,[0:0.1:2*pi]))
% plot(angle,s)
% title('Effect of changing k')
% xlabel('Phi in radians')
% ylabel('Amplitude')
% ylim([-400 400])
% legend('k = 1')
% subplot(4,1,2)
% s = eval(f(1,2,1,0,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('k = 2')
% ylim([-400 400])
% subplot(4,1,3)
% s = eval(f(1,3,1,0,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('k = 3')
% ylim([-400 400])
% subplot(4,1,4)
% s = eval(f(1,4,1,0,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('k = 4')
% ylim([-400 400])
% 
% %%
% 
% figure(201)
% angle = [0:0.1:2*pi];
% subplot(4,1,1)
% s = eval(f(1,1,1,0,[0:0.1:2*pi]))
% plot(angle,s)
% title('Effect of changing alpha')
% xlabel('Phi in radians')
% ylabel('Amplitude')
% ylim([-400 400])
% legend('alpha = 1')
% subplot(4,1,2)
% s = eval(f(1,1,1,pi/4,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('alpha = 2')
% ylim([-400 400])
% subplot(4,1,3)
% s = eval(f(1,1,1,pi/2,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('alpha = 3')
% ylim([-400 400])
% subplot(4,1,4)
% s = eval(f(1,1,1,pi,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('alpha = 4')
% ylim([-400 400])
% 
% 
% 
% %%
% figure(200)
% angle = [0:0.1:2*pi];
% subplot(4,1,1)
% 
% s = eval(f(1,1,1,0,[0:0.1:2*pi]))
% plot(angle,s)
% title('Effect of changing v')
% xlabel('Phi in radians')
% ylabel('Amplitude')
% ylim([-400 400])
% 
% legend('v = 1')
% subplot(4,1,2)
% s = eval(f(1,1,2,0,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('v = 2')
% ylim([-400 400])
% 
% subplot(4,1,3)
% s = eval(f(1,1,3,0,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('v = 3')
% ylim([-400 400])
% 
% subplot(4,1,4)
% s = eval(f(1,1,4,0,[0:0.1:2*pi]))
% plot([0:0.1:2*pi],s)
% xlabel('Phi in radians')
% ylabel('Amplitude')
% legend('v = 4')
% ylim([-400 400])


%%






