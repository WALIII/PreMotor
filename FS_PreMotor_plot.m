
function FS_PreMotor_plot(song,calcium,align,cell);


ds = 1000;
fs = 48000/ds;

cfs = 25;
align = align/cfs;

figure(); 
ax1 =  subplot(211);
song(song==0) = mean(min(song));
imagesc((1:size(song,2))/fs,[],song); colormap(bone);

freezeColors;
ax2 = subplot(212);
colormap(hot)
imagesc((1:size(calcium{cell},2))/cfs,1:size(calcium{cell},1),(calcium{cell}));
title('cell');
xlabel('time (seconds)')
ylabel('trials')
% 
linkaxes([ax1 ax2], 'xy');
xlim([align-2 align+4]);




figure(); 

l = linkage(song(:,round(align*fs):align*fs+2*fs), 'ward', 'correlation');

% subplot(3,1,3)
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);

calcium{cell}=(calcium{cell}(bb,:));
song = song(bb,:);
ax1 =  subplot(121);
imagesc((1:size(song,2))/fs,[],song); colormap(bone);
ax2 = subplot(122);
imagesc((1:size(calcium{cell},2))/cfs,1:size(calcium{cell},1),(calcium{cell}));


linkaxes([ax1 ax2], 'xy');
xlim([align-5 align+5]);

