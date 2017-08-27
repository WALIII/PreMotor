
function [Fin, ys] = FS_song_similarity(Syl2)
% Get Sim Scores

for ii = 1:size(Syl2,2) % for all syls
for i = 1:size(Syl2{5}.SDI,2); % for all trials

%   SDI formatting to calculate SIM score
conX{ii}(:,:,i) = (flipdim(Syl2{ii}.SDI{i},2));

%   Audio Stretch formating
GG_d = Syl2{ii}.audio_time{i}(1,:)-Syl2{ii}.audio_time{i}(2,:); %differences in timing
%GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
GG2_d2(:,i) = (sum(abs(GG_d)));


end;
Fin{ii}(1,:) = GG2_d2; % timing difference vector

% Get SIM SCORE
[sim_score] = FS_song_dff(conX{ii});
Fin{ii}(2,:) = sim_score; % spectral difference vector
end


figure();
hold on;
for i = 1:5
  plot(Fin{i}(1,:),Fin{i}(2,:),'*');
end


%% For a comparison across datasets:

% figure();
% hold on;
% g = colormap(hsv(10));
% for i = 1:5
%   scatter(Fin1{i}(1,:),Fin1{i}(2,:),[],g(i*2,:),'Marker','*');
%   scatter(Fin2{i}(1,:),Fin2{i}(2,:),[],g(i*2-1,:),'Marker','o');
% end
