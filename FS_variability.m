function [data stats] = FS_variability(calcium, align,Motif_ind)

% Get var score: mean( abs [zscore(trace)-zscore(mean)]/zscore(mean);

% Zscore to eliminate height differences- 

% Make matrixes
triala = 1;
trialb = 1;
Smh = 2;
range = align:align+30;
range2 = 1:30;

% Format Data
disp('Formatting data')
for cell = 1:size(calcium,2);
  for trial = 1:size(calcium{cell},1);
      if Motif_ind(3,trial) == 0; %
        temp = detrend(smooth(calcium{cell}(trial,range)));
        data.undirected(triala,:,cell) = (temp(:,1:end));
        triala = triala+1;
      elseif Motif_ind(3,trial) == 1; %
        temp = detrend(smooth(calcium{cell}(trial,range)));
        data.directed(trialb,:,cell) = (temp(:,1:end));
        trialb = trialb+1;
      end
  end
        triala = 1;
      trialb = 1;
end

% For average data = 
data.all = cat(1, data.directed,data.undirected);

% rank cells based on height
% sort(mean(mean(data.all(:,:,:),3)))
common = (mean(mean(data.all(:,:,:),3)',2)); % Common signal;

%mean subtract common signal;
X = (mean(data.directed(:,:,:),1));
X2 = squeeze(max(X))
[B(:,1),B(:,2)] = sort(X2,'descend');
% Get measurments 
counter = 1;
counterX = 1;




GG =  B(1:10,2)';
for i = 1:size(data.directed,1) %trials
for cell = GG
% sum of variance
sVD(:,counter) = sum(abs(((data.directed(i,range2,cell)-mean(data.directed(:,range2,cell),1)))));% Variance
% Average Variance
mVD(:,counter) = mean(abs(((data.directed(i,range2,cell)-mean(data.directed(:,range2,cell),1)))));% Variance
% Prominance
try
[pks,locs,w,p] = findpeaks(data.directed(i,range2,cell),'MinPeakProminence',2); %MaxPeakWidth'
[mp id] = max(p);

for ii = size(p)
pVD(:,counterX) = max(data.directed(i,range2,cell)-min(data.directed(i,range2,cell)));

counterX = counterX+1;
end
catch
%     G = max(data.directed(i,range2,cell))-min(data.directed(i,range2,cell));
%     if G>1
%      pVD(:,counterX) = G;   
%     counterX = counterX+1;
%     end
end
% Powerdiff
pdVD(:,counter) = mean(data.directed(i,range2,cell),2) -mean(mean(data.all(:,range2,cell),1));% Variance

counter = counter+1;
end
end




counterX = 1;
counter = 1;

for i = 1:size(data.undirected,1) %trials
for cell = GG%1:10;
% sum of variance
sVU(:,counter) = sum(abs(((data.undirected(i,range2,cell)-mean(data.all(:,range2,cell),1)))));% Variance
% Average Variance
mVU(:,counter) = mean(abs(((data.undirected(i,range2,cell)-mean(data.all(:,range2,cell),1)))));% Variance

% Prominance
try
[pks,locs,w,p] = findpeaks(data.undirected(i,range2,cell),'MinPeakProminence',2); %MaxPeakWidth'
[mp id] = max(p);

for ii = size(p)
pVU(:,counterX) = max(data.undirected(i,range2,cell)-min(data.undirected(i,range2,cell)));
counterX = counterX+1;
end
catch
%     pVU(:,counterX) = 0;% max(data.directed(i,range2,cell))-min(data.directed(i,range2,cell));
%     counterX = counterX+1;
end


% Powerdiff
pdVU(:,counter) = mean(data.undirected(i,range2,cell),2) -mean(mean(data.all(:,range2,cell),1));% Variance

counter = counter+1;
end
end




% VD(2,counter) = % Power
% figure();
% for cell = 1;
% hold on;
% figure(1);
% G{1} = data.undirected(:,:,cell)';
% G{2} = data.directed(:,:,cell)';
% scrapPlot(G);
% pause(0.1);
% hold off;
% end


figure();
hold on;
h2 = histogram(pVU,'FaceColor','m')
h1 = histogram(pVD,'FaceColor','g')
h1.Normalization = 'probability';
h1.BinWidth = 0.75;
h2.Normalization = 'probability';
h2.BinWidth = 0.75;




% Plot amplitude Differences

    X = (mean(data.directed(:,:,:),1));
    X2 = squeeze(max(X)-min(X))

    DCa = X2;
    
    X = (mean(data.undirected(:,:,:),1));
    X2 = squeeze(max(X)-min(X))
    UCa = X2;
    
    figure();
    title('difference in amp')
    hold on;
    scatter(UCa,DCa);
   x = [0 9];
y = [0 9];
line(x,y,'Color','red','LineStyle','--')





   Tx = (std(data.all(:,:,:),[], 1));
    X =  (std(data.directed(:,:,:),[], 1));
    X2 = ((squeeze(mean(X,2))-squeeze(mean(Tx))))-mean((squeeze(mean(X,2))-squeeze(mean(Tx))))
    DCb = X2;
    
    X = (std(data.undirected(:,:,:),[], 1));
    X2 = (squeeze(mean(X,2))-squeeze(mean(Tx)))-mean((squeeze(mean(X,2))-squeeze(mean(Tx))))
    UCb = X2;
    
    figure();
    title('Variance Difference')
    hold on;
    scatter(UCb,DCb);
 x = [-0.2 0.2];
 y = [-0.2 0.2];
line(x,y,'Color','red','LineStyle','--')

figure();

Ta = cat(1,UCa,DCa);
Tb = cat(1,UCb,DCb);



%     figure();
%     title('comparison')
%     hold on;
%     scatter((DCa)/max(Ta),(DCb)/max(Tb),'g');
%     scatter((UCa)/max(Ta),(UCb)/max(Tb),'m');
% x = [0 2];
% y = [0 2];
% line(x,y,'Color','red','LineStyle','--')



% figure(); 
% hold on;
% histogram((DCa)/max(Ta)-(DCb)/max(Tb),10,'FaceColor','g');
% histogram((UCa)/max(Ta)-(UCb)/max(Tb),10,'FaceColor','m');
% 
% XX = DCb-UCb
% [iu(:,1) iu(:,2)] = sort(XX)






