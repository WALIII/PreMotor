function [sim_score, vector_score, A_diff,S_diff] = FS_PreMotor_FeaturePlot(WARPED_TIME,WARPED_audio,Gconsensus)
  % plot traces that correspond to warping locations
  % d050117
  % WAL3


  % Get Spectral information from adjusted audio
  for i = 1:size(WARPED_audio,2)
  [sim_score{i}, vector_score{i}] = FS_song_dff(Gconsensus{1,i}{1});
  end

  % Plot F
  nn = 50;
for ii = 1:size(WARPED_audio,2)
  for i = 1:size(vector_score{ii},2)
  S_diff{ii}(:,i) = tsmovavg(vector_score{ii}(:,i)','s',nn); % Spectral diff
  end
end


  counter = 1;
for ii = 1:size(WARPED_TIME,2)
  for i = 1:size(WARPED_TIME{ii},2)

  GG = diff(WARPED_TIME{ii}{i}(1,:)-WARPED_TIME{ii}{i}(2,:));
  A_diff{ii}(:,i) = tsmovavg(abs(GG),'s',nn);
  end

  % nn = 50; % Smoothing factor
  %
  % GG3 = mean(A{ii});
  % GG4 = tsmovavg(abs(GG3),'s',nn);
  % A_diff{ii} = [zeros(1,nn/2) GG4(nn/2:end-nn/2) zeros(1,nn/2-1)];
  % clear GG;
end



% PLOT T

  % hold on;
  % plot(WARPED_TIME_d{1}(1,1:end-1),zscore(abs(GG4_d))*2000,'g','LineWidth',3);
  % plot(WARPED_TIME_u{1}(1,1:end-1),zscore(abs(GG4_u))*2000,'m','LineWidth',3);
  %
