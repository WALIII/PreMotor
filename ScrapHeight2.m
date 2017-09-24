function ScrapHeight2(calcium, align, Motif_ind)
%plot the output or ScrapHeight.m



  % MAke matrixes
  triala = 1;
  trialb = 1;
  Smh = 2;
  range = align-Smh-10:align+30;

  disp('Formatting data')
  for cell = 1:size(calcium,2);
    for trial = 1:size(calcium{cell},1);
        if Motif_ind(3,trial) == 0; %
          temp = tsmovavg(calcium{cell}(trial,range),'s',Smh);
          data.undirected(triala,:,cell) = temp(:,Smh+1:end);
          data.utime(triala) = Motif_ind(4,trial);
          triala = triala+1;
        elseif Motif_ind(3,trial) == 1; %
          temp = tsmovavg(calcium{cell}(trial,range),'s',Smh);
          data.directed(trialb,:,cell) = temp(:,Smh+1:end);
          data.dtime(trialb) = Motif_ind(4,trial);
          trialb = trialb+1;
        end
    end
          triala = 1;
        trialb = 1;
  end



% Undirected Analysis

for trials = 1:size(data.undirected,1); % we want to measue across cells, for every trial
 X(trials,1) = mean(mean(data.undirected(trials,:,:),2)); % mean power (avg over time) across trials
 % X(trial,2) = mean(std(data.directed(:,:,i)));% std
 X(trials,2) = prctile(mean(data.undirected(trials,:,:),2),95); % 95 percentile
 X(trials,3) = prctile(mean(data.undirected(trials,:,:),2),5);% 5 percentile
 X(trials,4) = data.utime(trials) % time
 end

% Directed Analysis
 for trials = 1:size(data.directed,1); % we want to measue across cells, for every trial
  X2(trials,1) = mean(mean(data.directed(trials,:,:),2)); % mean power (avg over time) across trials
  % X(trial,2) = mean(std(data.directed(:,:,i)));% std
  X2(trials,2) = prctile(mean(data.directed(trials,:,:),2),95); % 95 percentile
  X2(trials,3) = prctile(mean(data.directed(trials,:,:),2),5);% 5 percentile
  X2(trials,4) = data.dtime(trials) % time
  end

 figure();
 ax1 = subplot(211)
 hold on;
 plot(X(:,4),X(:,1),'r*')
  plot(X(:,4),X(:,2),'g*')
   plot(X(:,4),X(:,3),'b*')
      title('undirected trials')
datetick('x','HH')
 ax2 = subplot(212)
 hold on;
 plot(X2(:,4),X2(:,1),'r*')
  plot(X2(:,4),X2(:,2),'g*')
   plot(X2(:,4),X2(:,3),'b*')
   title('directed trials')
datetick('x','HH')
linkaxes([ax1 ax2],'xy')


%  X2(trial,cell,1) = mean(V.D(1,indD));
%  X2(trial,cell,2) = std(V.D(1,indD));
%  X2(trial,cell,3) = prctile(V.D(1,indD),95);
%  X2(trial,cell,4) = prctile(V.D(1,indD),5);
%  x2(trial,cell,5) = V.D(4,indD(1));
% end
%
% figure();
% title('mean = r std = b')
% plot(mean
