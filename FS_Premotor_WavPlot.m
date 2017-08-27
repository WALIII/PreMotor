function idx = FS_Premotor_WavPlot(song,align)


ds = 1000;
fs = 48000/ds;

cfs = 25; % video framerate
align = align/ds;

figure(); 

song(song==0) = mean(min(song));
imagesc((1:size(song,2))/fs,[],song); colormap(bone);




figure(); 

l = linkage(song(:,round(align):align+3*fs), 'ward', 'correlation');

% subplot(3,1,3)
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);


song = song(bb,:);

imagesc((1:size(song,2))/fs,[],song); colormap(bone);
freezeColors;


idx = bb;
% 
% xlim([align-5 align+5]);

