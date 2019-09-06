function [data] = FS_Data(calcium,align,Motif_ind,mm,mp)


% Make matrixes
Max_motifs = 3;
triala = 1;
trialb = 1;
Smh = 3;
range = align-mm:align+mp;
% range2 = 1:30;

% Format Data
warning off
disp('Formatting data')
for cell = 1:size(calcium,2);
  for trial = 1:size(calcium{cell},1);
      if Motif_ind(3,trial) == 0 && Motif_ind(1,trial) < Max_motifs;
        % temp = detrend(smooth(calcium{cell}(trial,range)));
        temp = (tsmovavg(calcium{cell}(trial,range),'s',Smh)); temp(:,1:Smh) = []; temp = detrend(temp);
       
        data.undirected(triala,:,cell) = (temp(:,1:end));
        triala = triala+1;
      elseif Motif_ind(3,trial) == 1 && Motif_ind(1,trial) < Max_motifs;
       %  temp = detrend(smooth(calcium{cell}(trial,range)));
       temp = (tsmovavg(calcium{cell}(trial,range),'s',Smh)); temp(:,1:Smh) = []; temp = detrend(temp);
        data.directed(trialb,:,cell) = (temp(:,1:end));
        trialb = trialb+1;
      end
  end
        triala = 1;
      trialb = 1;
end
try
% For average data = 
data.all = cat(1, data.directed,data.undirected);
catch
end


%unsorted

% Format Data
disp('Formatting data')
for cell = 1:size(calcium,2);
  for trial = 1:size(calcium{cell},1);
        temp = detrend(smooth(calcium{cell}(trial,range)));
        temp(1:Smh,:) = [];
        data.unsorted(trialb,:,cell) = temp(:,1:end);
        data.raw_unsorted(trialb,:,cell) = calcium{cell}(trial,range); 
        trialb = trialb+1;
            
  end
         trialb = 1;   
end

end

