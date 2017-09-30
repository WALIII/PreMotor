
function FS_Clust_time(ROI,data)
% FS_Clust_time.m

% WAL3
% d050117

% Just taking in the ROI data, deterimne how ROI correlations vary by:
%     A. Their proximity ( euclidean distance)
%     B. Their time of firing. ( difference in time)



% Format the ROI data appropritaly, seperate by motif:
% [data] = FS_Format_Dropout(roi_ave, directed,undirected, motif)
% data.undirected = zscore(data.undirected(:,:,:),1,2);
% data.directed = zscore(data.directed,1,2);

% Cluster the data by ROI variance correlations
[eig1,eig2,sorting]= FS_cellclust_comp(data.directed,data.undirected);


% Get time of firing information
[indX, B, C]= FS_schnitz(data);

[M1,I1] = max(B'); % this is the timing information on the directed data ;
[M2,I2] = max(C'); % this is the timing information on the undirecetd data


for i = 1:size(I1,2) % sort by time of firing
  for ii = 1:size(I2,2)
    G(ii,i) = abs(I1(ii)-I1(i));
  end
end

l = linkage(G, 'average', 'correlation');

figure();
imagesc(G);

GG = G(sorting,sorting);
figure();
imagesc(GG);

% Get proximity
for i = 1:size(ROI.coordinates,2);
    hold on;
   Locs(i,:) = mean(ROI.coordinates{i});
   plot(Locs(i,1),Locs(i,2),'*');
end



D = pdist2(Locs,Locs);
    figure();
    imagesc(D)
DD = D(sorting,sorting);
  figure();
  imagesc(DD)
  title('sorted by Covariance matrix')



B_1 = DD(:)%space
B_11 = GG(:)% in time

B_2 = abs(eig1(:))
B_3 = abs(eig2(:))



figure();
plot(B_1,B_2,'g*');
hold on;
plot(B_1,B_3,'m*');
title('In space')

figure();
plot(B_11,B_2,'g*');
hold on;
plot(B_11,B_3,'m*');
title('In Time')


figure();
h11= histogram(B_2,'facecolor',[0 1 0],'facealpha',.5,'edgecolor','none'); hold on;
h21= histogram(B_3,'facecolor',[1 0 1],'facealpha',.5,'edgecolor','none'); hold on;
h11.Normalization = 'probability';
 h11.BinWidth = .05;
h21.Normalization = 'probability';
 h21.BinWidth = .05;



figure();
[f1,x1,flo1,fup1] = ecdf(abs(B_3));
[f2,x2,flo2,fup2] = ecdf(abs(B_2));
plot(x1,f1,'m', 'LineWidth',2);
hold on;
plot(x2,f2,'g', 'LineWidth',2);

h = patch([x2(2:end-1)' fliplr(x2(2:end-1)')],[flo2(2:end-1)' fliplr(fup2(2:end-1)')],'g');
alpha(.3)
set(h,'EdgeColor','None');
h = patch([x1(2:end-1)' fliplr(x1(2:end-1)')],[flo1(2:end-1)' fliplr(fup1(2:end-1)')],'m');
alpha(.3)
set(h,'EdgeColor','None');


figure();
subplot(121)
imagesc(DD)
colorbar
subplot(122)
imagesc(eig1,[-.3 .7])
colorbar

%%%=============[ PLOT]==============%%
%% sort by COV matrix

figure();
subplot(331)
imagesc(-GG)
title('Peak time between ROIs')
ylabel('Sort By Covariance Matrix')
colorbar
subplot(332)
imagesc(-DD)
title('Euclid distance between ROIs')
colorbar
subplot(333)
imagesc(eig1,[-.3 .7])
title('Covariance Matrix')
colorbar

%% Sort By Time
l = linkage(-GG, 'average', 'correlation');
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);


subplot(334)
imagesc(-GG(bb,bb))
colorbar
ylabel('Sort By Peak Time')
subplot(335)
imagesc(-DD(bb,bb))
colorbar
subplot(336)

imagesc(eig1(bb,bb),[-.3 .7])
colorbar

%% Sort By space
l = linkage(DD, 'average', 'correlation');
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);

subplot(337)
imagesc(-GG(bb,bb))
colorbar
ylabel('Sort By Distance')
subplot(338)
imagesc(-DD(bb,bb))

colorbar
subplot(339)
imagesc(eig1(bb,bb),[-.3 .7])
colorbar



%%==================================
%% Sort By space
l = linkage(eig2, 'average', 'correlation');
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);

figure();
subplot(331)
imagesc(-GG(bb,bb))
title('Peak time between ROIs')
ylabel('Sort By Covariance Matrix')
colorbar
subplot(332)
imagesc(-DD(bb,bb))
title('Euclid distance between ROIs')
colorbar
subplot(333)

imagesc(eig2(bb,bb),[-.3 .7])
title('Covariance Matrix')
colorbar

%% Sort By Time
l = linkage(-GG, 'average', 'correlation');
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);


subplot(334)
imagesc(-GG(bb,bb))
colorbar
ylabel('Sort By Peak Time')
subplot(335)
imagesc(-DD(bb,bb))
colorbar
subplot(336)
imagesc(eig2(bb,bb),[-.3 .7])
colorbar

%% Sort By space
l = linkage(DD, 'average', 'correlation');
c=cluster(l,'maxclust',5);
[aa,bb]=sort(c);

subplot(337)
imagesc(-GG(bb,bb))
colorbar
ylabel('Sort By Distance')
subplot(338)
imagesc(-DD(bb,bb))
colorbar
subplot(339)

imagesc(eig2(bb,bb),[-.3 .7])
colorbar



% 
% figure();
% plot(DD(:),GG(:),'*');
%
% G6(:,1) = DD(:);
% G6(:,2) = GG(:);
%
% binedge = 0:50:600;                                       % Define Bin Edges
% [acount, idx] = histc(G6(:,1), binedge);                 % Bin ‘a’, Return Index Vector
% meanb = accumarray(idx+1, G6(idx+1,2), [], @mean);       % Get Mean Of Corresponding ‘b’
% figure()
% bar(binedge, acount, 'histc')
% grid
% figure(); plot(meanb)


% % Plot proximity correlations
% figure();
% imagesc(im1_rgb,'Alpha',eig1); % fade in by correlation strength
%
% % Plot Timing correlations
% figure();
% imagesc(im1_rgb,'Alpha',eig1); % fade in by correlation strength
