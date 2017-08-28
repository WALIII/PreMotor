function [WARPED_TIME, WARPED_audio, Index] = FS_PreMotor_Warp(WAVcell,template)
% FS_warp_song.m

% For getting info on dynamic time warping of song data.

% WALIII
% 08.27.17

% Use:
% >> WAV = CY_Get_wav ( in _manclust folders for aquiring aligned songs)
% Needs: FS_Spectrogam.m


% Seperate the Motifs:

% Seperate Data, if it is first, last, only, or middle.
% [WAVcell] =  FS_Wav_sort(Motif_ind,align,song_r)


% Last step is to use CY_Get_Cosensus:
% >> [Gconsensus_d,F,T] = CY_Get_Consensus(WARPED_audio_d)
% >> [Gconsensus_u,F,T] = CY_Get_Consensus(WARPED_audio_u)

% im1 = mean(Gconsensus_d{1},3);
% im2 = mean(Gconsensus_u{1},3);
% XMASS_song(flipdim(im1(:,:),1),flipdim(im2(:,:),1),flipdim(im2(:,:),1));

counter = 1;
fs = 48000; % sampling rate
% template = WAV_d{5}(0.25*fs:end-0.75*fs); % pick a song to be the template
% template = WAV_d{5}(0.25*fs:end-0.75*fs); % pick a song to be the template


for ii = 1:size(WAVcell,2)
%directed
for i = 1:size(WAVcell{ii},2);
    try
[song_start, song_end, score_d(counter,:)] = find_audio(WAVcell{ii}{i}, template, fs, 'match_single', true,'constrain_length', 0.25);
[WARPED_TIME{ii}{counter} WARPED_audio{ii}(:,counter)]  = warp_audio(WAVcell{ii}{i}(song_start*fs:song_end*fs,:), template, fs,[]);
% GG_d = WARPED_TIME_d{counter}(1,:)-WARPED_TIME_d{counter}(2,:); %differences in timing
% GG2_d(counter,:) = diff(GG_d); % Take the derivative of the vector, to get moments of change
   counter = counter+1;
Index{ii}(i,1) = i;
catch
    disp('Pass')
Index{ii}(i,1) = 0;
end;
end
counter = 1;

end
