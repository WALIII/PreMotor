
function F2_1(song_r1,song_r2,align1,align2);


% figure(); 
% 
% imagesc(song_r2(:,(align2/25)*48000:(align2/25+1)*48000))

clear IMAGE
clear T

% for i = 1:size(song_r1,1)
%     [IMAGE1(:,:,i), T]= FS_Spectrogram(song_r1(i,((align1-10)/25)*48000:(align1/25+1)*48000),48000);
% end
% 
% for i = 1:size(song_r2,1)
%     [IMAGE2(:,:,i), T]= FS_Spectrogram(song_r2(i,((align2-10)/25)*48000:(align2/25+1)*48000),48000);
% end


for i = 1:size(WARPED_audio_d,2)
    [IMAGE1(:,:,i), T]= FS_Spectrogram(WARPED_audio_d(:,i)',48000);
end

for i = 1:size(WARPED_audio_u,2)
    [IMAGE2(:,:,i), T]= FS_Spectrogram(WARPED_audio_u(:,i)',48000);
end

% Time warp Spectrograms:

im1 = mean(IMAGE1,3);
im2 = mean(IMAGE2,3);

% figure(); imagesc(flipdim(C,1));

XMASS_song(flipdim(im1(:,:),1),flipdim(im2(:,:),1),flipdim(im2(:,:),1))

