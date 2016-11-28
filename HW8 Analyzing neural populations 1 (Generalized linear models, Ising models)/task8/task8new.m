% Task 8 Population analysis using Latent-Variable Models
% By Po-Hsuan Huang

%% (1) Fit model on toy data and verify the fit

% (a) Generate some toy data to test the GPFA code

rng(8437); % ensure deterministic behavior

trials = 100;
bins = 20;
neurons = 10;

% model parameters
C = sort(0.5 * randn(neurons, 1));  % weights
R = diag(exp(randn(neurons, 1)));   % residual variances

% generate latent state
win = gausswin(10);
X = filter(win, 1, randn(bins * trials, 1))';
X = X / std(X);

% generate observations
Y = C * X + sqrt(R) * randn(neurons, bins * trials);

Y = reshape(Y, neurons, bins, trials);
% substract mean across trail for each neuron and each bin
for i = 1:neurons
    for j = 1:bins
       Y(i,j,:)=  Y(i,j,:) - mean( Y(i,j,:));
  
    end
end

%% Fit model

% TO DO: add your code here
model = GPFA('Tolerance', 1e-6);
model = model.fit(Y, 1);
signflip = -1;
C1 = signflip.*model.C;  % something wrong in the GPFA result in the sign flip of the wieght and latent factor.
R1 = model.R;
% noise correlation matrix
N1 = C1*C1'+R1;
N = C*C' + R; 
% latent state
EX=estX(model,Y);

% Plot ground truth vs. inferred: 
%       (a) weights C
    figure(1)
    clf
    plot(1:10,C,'-ob',1:10,C1,'-or')
    legend('true','est')
    title('Weight on each cell','FontSize',18)
    xlabel('weight')
    ylabel('value')
%      (b) residual variances R
    figure(2)
    clf
    subplot(2,2,1)
    surface(R)
    axis tight

    title('true Residue','FontSize',24)
    subplot(2,2,2)
    surface(R1)
    title('est Residue','FontSize',24)
    axis tight

%       (c) correlation matrix
   
    subplot(2,2,3)
    surface(N)
    title('true Noise','FontSize',24)
    axis tight
    
    subplot(2,2,4)
    surface(N1)
    title('est Noise','FontSize',24)
    axis tight

%     (d) latent state X
%%
    figure(4)
    clf
    EX_p = signflip*reshape(EX,1,(bins*trials));
    plot(1:2000,X,'b',1:2000, EX_p,'r')
    xlabel('timebin for 100 consequtive trials')
    title('true latent state vs est latent state','FontSize',18)
    legend('true latent state','estimated latent state')

%% (2) Fit GPFA models and perform model comparison

load task8_data

% split data into training and test set
nTrials = 100;
trainTrials = 80;
t = randperm(nTrials);
train = t(1 : trainTrials);  % train trials 80%
test = t(trainTrials + 1 : end); % test trials %20


% TO DO: subtract average response across trials
    testX = spikeCounts(:,:,test);
    trainX = spikeCounts(:,:,train); 
    
% substract mean across trail for each neuron and each bin
for i = 1:55      %neurons
    for j = 1:20  %bins
       trainX(i,j,:)=  trainX(i,j,:) - mean(trainX(i,j,:));
    end
end
for i = 1:55      %neurons
    for j = 1:20  %bins
       testX(i,j,:)=  testX(i,j,:) - mean(testX(i,j,:));
    end
end
    model = GPFA('Tolerance', 1e-6);
%
% fit models
pmax = 5;
for p = 0 : pmax
    % TO DO: fit model
    fitter = model.fit(trainX, p);
    
    % TO DO: get log-likelihood
    [~, ~, logLike] = estX(fitter,testX);
    LL(p+1)= logLike;
end

save('loglike.m','logLike')

% plot log-likelihood
figure(5)
plot(LL,'-*')
%title('log-likelihood vs # hidden variables','FontSize',20)
xlabel('# of hidden variables')
ylabel('Log-likelihood')
% TO DO


%% (3) Visualize population rasters and latent state
load task8_data

% p = 1 ;% single latent state
% TO DO
% for i = 1:55      %neurons
%     for j = 1:20  %bins
%        spikeCounts(i,j,:)=  spikeCounts(i,j,:) - mean(spikeCounts(i,j,:));
%     end
% end
% 
%     fitter = model.fit(spikeCounts, p);
%     [EX3] = estX(fitter,spikeCounts);
%     EX3_p = permute(EX3,[2,3,1]); 
%     C3 = fitter.C;
%     [~,inx] = sort(C3,'descend');

% fit the model
p = 1;
Y = spikeCounts - repmat(mean(spikeCounts,3),[1,1,nTrials]);
model = GPFA('Tolerance', 1e-6);
model = model.fit(Y, p);
[EX3] = model.estX(Y);
EX3 = permute(EX3,[2,3,1]);
time = linspace(0,2000,20); 
scale = 20;
[~,idx] = sort(-model.C,'descend');
spikeTimes = spikeTimes(idx,:);


% sort the neurons by GPFA weights
[~,idx] = sort(model.C,'descend');
spikeTimes = spikeTimes(idx,:);


figure(6)  
clf

% raster plot for spikeCounts of all neurons
subplot(1,2,1)

    line([0,0],[1.4,-550.4])   
    hold on
 
    for  i = 1:10 %  trials
        norm = max(EX3(:,i))- min(EX3(:,i));
        meean = mean(EX3(:,i));
        plot(time, -(i-1)*55  -55/2 + scale/norm*(EX3(:,i)-meean),'r')
       for j = 1:55 % neurons   
          times = spikeTimes{j,i};
          for k = 1:length(times)
             
              line([times(k);times(k)],-[(i-1)*55+(j+0.4); (i-1)*55+(j-0.4)], 'LineWidth',1);
            
          end
       end
     line([-500, 2.5e3],-[(i)*55+0.5,(i)*55+0.5])
    end
hold off
set(gca,'XAxisLocation','top')
xTick={'-500','0','500','1000','1500','2000','2500'};
set(gca,'XTickLabel',xTick);
set(gca,'YTickLabel',[]);
ylim([-550 0]);
xlim([-500 2500]);
xlabel('time ms')
axis tight

subplot(1,2,2)

    line([0,0],[1.4,-550.4])   
    hold on

    for  i = 11:20 %  trials
        norm = max(EX3(:,i))- min(EX3(:,i));
        meean = mean(EX3(:,i));
        plot(time, -(i-11)*55 - 55/2  + scale/norm*(EX3(:,i)-meean),'r')
       for j = 1:55 % neurons   
          times = spikeTimes{j,i};
          for k = 1:length(times)
            
              line([times(k),times(k)],-[(i-11)*55+(j+0.4), (i-11)*55+(j-0.4)], 'LineWidth',1);
   
          end
       end
    line([-500, 2.5e3],-[(i-10)*55+0.5,(i-10)*55+0.5])
    end
hold off
set(gca,'XAxisLocation','top')
xTick={'-500','0','500','1000','1500','2000','2500'};
set(gca,'XTickLabel',xTick);
set(gca,'YTickLabel',[]);
ylim([-550 0]);
xlim([-500 2500]);
xlabel('time ms')
axis tight
    
% Raster plot for the population
% line([0,0],[0.4,-20.4])
% 
% for j = 1:55 % neurons
%       %RasterSpikes{i}  =[];
%     for  i = 1:20 %  fist 20trials
%       %RasterSpikes{i} = [RasterSpikes{i} ;spikeTimes{j,i}];
%       times = spikeTimes{i,j};
%       for k = 1:length(times)
%       line([times(k),times(k)],-[i+0.4,i-0.4], 'LineWidth',1);
%       end
%     end
%     line([-500, 2.5e3],-[i+0.5,i+0.5])
% end

%% raster polt for trajectory of latent states (first 20 trials)

figure(7)
EX3_p = permute(EX3,[2,3,1])
time = linspace(-500,2500,20); 
suptitle('latent states of the population')
for i = 1:20
subplot(10,2,i)
plot(time,EX3_p(:,i),'r')
%axis off
end


%% (4) Visualize noise correlation matrix and low-rank approximations
load task8_data
model = GPFA('Tolerance', 1e-6);

% TO DO
clf
SC=spikeCounts - repmat(mean(spikeCounts,3),[1,1,100]); % substract mean
SCre = reshape(SC, 55,2000);
%%
% plot true noise correlation matirx
figure(8)
%subplot(1,3,1)
C_tre = corrcov(SCre*SCre');   % convert covarianc matrix to correlation matrix
title('true correlation matrix')
imagesc(C_tre)
axis tight
%% plot noise correlation matirx of one latent variable
figure(9)
%subplot(1,3,2)
fitter = model.fit(SC, 1,'hist');
C1 = fitter.C;
R1 = fitter.R;
N1 = C1*C1'+R1;
N1 = corrcov(N1);
imagesc(N1)
axis tight
title('1 latent state')
%% plot noise correlation matirx of five latent variables
figure(10)
%subplot(1,3,3)
    fitter = model.fit(SC, 5,'hist');
C5 = fitter.C;
R5 = fitter.R;
N5 = C5*C5'+R5;
N5 = corrcov(N5);
imagesc(N5)
axis tight
title('5 latent states')
