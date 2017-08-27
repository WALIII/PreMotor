


% Concat vectors

for i = 1:5
  GG3(1,:) = [Fin1{1}(1,:),Fin1{2}(1,:),Fin1{3}(1,:),Fin1{4}(1,:),Fin1{5}(1,:)];
  GG3(2,:) = [Fin1{1}(2,:),Fin1{2}(2,:),Fin1{3}(2,:),Fin1{4}(2,:),Fin2{5}(2,:)];
  GG3(3,:) = [Fin2{1}(1,:),Fin2{2}(1,:),Fin2{3}(1,:),Fin2{4}(1,:),Fin1{5}(1,:)];
  GG3(4,:) = [Fin2{1}(2,:),Fin2{2}(2,:),Fin2{3}(2,:),Fin2{4}(2,:),Fin2{5}(2,:)];

% For paper
  figure();
  hold on;
  g = colormap(hsv(10));
  for i = 1:5
    scatter(Fin1{i}(1,:),Fin1{i}(2,:),[],g(i*2,:),'Marker','*');
    scatter(Fin2{i}(1,:),Fin2{i}(2,:),[],g(i*2-1,:),'Marker','o');
  end

% Histograms

figure();

% h11 = histogram(GG3(2,:),'facecolor',[1,0,0],'facealpha',.5,'edgecolor','none'); hold on;
h11 = histogram(GG3(1,:),'facecolor',[1,0,0],'facealpha',.5); hold on;
h12 = histogram(GG3(3,:),'facecolor',[0,0,1],'facealpha',.5); hold on;
hold off;
h11.BinWidth = 1;
h12.BinWidth = 1;
h11.Normalization = 'probability';
h12.Normalization = 'probability';


  figure();
  hold on;
  histogram(GG3(2,:));
  histogram(GG3(4,:));

%  z score normalized

figure();
hold on;
g = colormap(hsv(10));
for i = 1:5
  scatter(zscore(Fin1{i}(1,:)),zscore(Fin1{i}(2,:)),[],g(i*2,:),'Marker','*');
  scatter(zscore(Fin2{i}(1,:)),zscore(Fin2{i}(2,:)),[],g(i*2-1,:),'Marker','o');
end



% mean subtracted:

figure();
hold on;
g = colormap(hsv(10));
for i = 1:5
  scatter(Fin1{i}(1,:)-mean(Fin1{i}(1,:)),Fin1{i}(2,:)-mean(Fin1{i}(2,:)),[],g(i*2,:),'Marker','*');
  scatter(Fin2{i}(1,:)-mean(Fin2{i}(1,:)),Fin2{i}(2,:)-mean(Fin2{i}(2,:)),[],g(i*2-1,:),'Marker','o');
end

% comparison

figure();
hold on;
g = colormap(hsv(10));
for i = 1:5
  scatter(zscore(Fin1{i}(1,:)-mean(Fin1{i}(1,:))),zscore(Fin2{i}(1,:)-mean(Fin2{i}(1,:))),[],g(i*2,:),'Marker','*');
  scatter(zscore(Fin1{i}(2,:)-mean(Fin1{i}(2,:))),zscore(Fin2{i}(2,:)-mean(Fin2{i}(2,:))),[],g(i*2-1,:),'Marker','o');
end


%%%%%%%%%%%%%%%%%%%

XMASS_song(flipdim(im1(:,:),1),flipdim(im2(:,:),1),flipdim(im2(:,:),1));
hold on;

GG_av(counter,:) = diff(GG_d);
plot




figure(); plot(mean(vector_score,2));



figure();
nn = 10;
%directed
for i = 1:100;
MVS(:,i) = tsmovavg(vector_score(:,i)','s',nn);
end
plot(zscore(mean(MVS,2))*2000,'g','LineWidth',3);








%
