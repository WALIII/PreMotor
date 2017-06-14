function FS_Premotor_plotSong(song,align)

fs = 48000/1000;
align = align/1000;

figure(); 

l = linkage(song(:,round(align):round(align)+round(2.5*fs)), 'ward', 'correlation');

% subplot(3,1,3)
c=cluster(l,'maxclust',10);
[aa,bb]=sort(c);


song = song(bb,:);
% song = song+abs((min(min(song))));
imagesc((1:size(song,2))/fs,[],song); colormap(bone);
colorbar

xlim([align/fs align/fs+4]);
