
function [idx, calcium, song] = FS_PreMotor_plot2(song,calcium,align,cell,Motif_ind,indices);

% Same as FS_PreMotor_Plot, but you can plot/sort based on the Motif number.

warning off

% Remove indexes that don't hold what you want
% RULE
% 
% find( Motif_ind(1,:) ==  Motif_ind(2,:));%
%
if nargin < 6
indices = 1:size(calcium,2); 
end


for i = 1:size(calcium,2)
    calcium{i} = calcium{i}(indices,:);
end
song =  song(indices,:);


ds = 1000;
fs = 48000/ds;

cfs = 25; % video framerate
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

l = linkage(song(:,round((align-0.5)*fs):align*fs+1*fs), 'ward', 'correlation');

% subplot(3,1,3)
c=cluster(l,'maxclust',50);
[aa,bb]=sort(c);

calcium{cell}=((calcium{cell}(bb,:)));
song = song(bb,:);
ax1 =  subplot(211);
imagesc((1:size(song,2))/fs,[],song); colormap(bone);
freezeColors;
ax2 = subplot(212);
imagesc((1:size(calcium{cell},2))/cfs,1:size(calcium{cell},1),(calcium{cell}));
colormap(hot);


idx = bb;
linkaxes([ax1 ax2], 'xy');
xlim([align-5 align+5]);
