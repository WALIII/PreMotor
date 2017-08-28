function [C,F,T,IMAGE1] = FS_Premotor_AvgSpectrogram(song_r,align,s)

% input:
% song_r = aligned spectrograms
% align = alignment point
% s = seconds ( default = 1)

% params
padding = 0.1 % seconds


%
%sT = ((align/25)*48000)-padding*48000
sT = ((align/25)*48000);
eT = (align/25)*48000+(s*48000)+padding*48000


G = song_r(:,:);



for i = 1:size(G,1)
[IMAGE1(:,:,i), T, F]= FS_Spectrogram(G(i,:),48000);
end


figure();
rr = 5;
hold on;
for i = 1:rr
subplot(rr,1,i)

imagesc(flipdim(IMAGE1(:,:,i),1));
end



figure();
C = mean(IMAGE1,3);
figure();
imagesc(T,F,C);set(gca,'YDir','normal');
ylim([0 9000]);




% TO DO: Warped Spectrograms
% for i = 1:size(song_r1,1)
% [IMAGE1(:,:,i), T]= FS_Spectrogram(WARPED_audio_d(i,:),48000);
% end

