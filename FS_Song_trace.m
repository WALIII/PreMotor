
function FS_Song_trace(song_r1, calcium1)


figure();


hold on;
for i = 1:5;
h(i) = subplot(5,1,i);
FS_Spectrogram(song_r1(i,:),48000);
colormap(bone);

counter = 1;
%16 36 41
col =  {'r','g','b'}%{'c','m','y'};%{'r','g','y','m','c','b'}; %{'r','g','b'}'%
for cell = [14 15 19]%[14 15 16 19 11 23] %[14 15 19]% [16 36 41]
data = tsmovavg(calcium1{1,cell}(i,:),'s',3);
data(:,1:4) = 0;
plot((1:length(calcium1{1}))/25,2000+data*900,col{counter},'LineWidth',1.5);
counter = counter+1;
end


end
linkaxes(h,'xy');
xlim([5 18])