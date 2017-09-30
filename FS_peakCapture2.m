

function [D,U] = FS_peakCapture2(data)
% get peak times(locations) and height of these peaks

n = 2; % maybe could be higher...


for cell = 1:size(data.directed,3)

GG = squeeze(data.directed(:,:,cell)'); M = mean(prctile(GG,8));%mean(GG);
GG = bsxfun(@minus,GG,M);
GG2 = squeeze(data.undirected(:,:,cell)'); M2 = mean(prctile(GG2,8));%mean(GG2);
GG2 = bsxfun(@minus,GG2,M2);

GG3 = horzcat(GG,GG2); % combine directed and undirected; 

GGG = GG3(:); %-abs(mean(GG3(:)));

GGG = GGG(1:2*size(GG(:),1)); % trial match


% plot
[pks{cell},locs{cell}] = findpeaks(GGG,'MinPeakWidth',1,'MinPeakHeight',n*std(GGG));

% 

%Check data manually.
figure();
plot(GGG); hold on; plot(locs{cell},pks{cell},'*');
line([size(GG(:),1) size(GG(:),1)], [-10 10]);

H = find(locs{cell} > size(GG(:),1));
H2 = find(locs{cell} < size(GG(:),1));
 D.locs{cell} = locs{cell}(H);
 D.pks{cell} = pks{cell}(H);
 D.Tpks(:,cell) = size(D.pks{cell},1)/size(data.directed,1);

 
 U.locs{cell} = locs{cell}(H2);
 U.pks{cell} = pks{cell}(H2);
 U.Tpks(:,cell) = size(U.pks{cell},1)/size(data.directed,1);

end







