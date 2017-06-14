
function [condition, offset, sorted_song] = FS_Premotor_condition(song,song_r,calcium,align)

% Split into conditions for the same alignment, then use :
% FS_Premotor_trace_comp(condition1,offset)
% WALIII


fs = 48000;

% Downsample song:
for i = 1:size(song,1);
SS(i,:) = downsample(song(i,:),1000);
end

A = (((align)/25)*fs)/1000;


% Plot Sorted Song:
figure();
imagesc(SS);
figure(); 
l = linkage(SS(:,A:A+40), 'ward', 'correlation');

% subplot(3,1,3)
c=cluster(l,'maxclust',4);
[aa,bb]=sort(c);

SS2 = SS(bb,A:A+40);
imagesc(SS2); colormap(bone);


for i = unique(aa)'
    counter = 1;
for ii = find(aa==i)'
    for iii = 1:size(calcium,2); % for all cells
    condition{i}{iii}(counter,:) = calcium{1,iii}(bb(ii),:); 
    end
    sorted_song{i}(counter,:) = song_r(bb(ii),((align-30)/25)*fs:((align+60)/25)*fs); % cut out song
    counter = counter+1;
end

offset{i} = align; % same offset each time;
end

% plot one cell

