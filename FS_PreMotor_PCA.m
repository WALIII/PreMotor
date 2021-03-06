function [output] = FS_PreMotor_PCA(Cal,Aln);


Aln{1};
AlignBound = (Aln{1})+5:(Aln{1}+35);

for group = 1:2;%1:size(Cal,2) % Each 'Group' is a subset of aligned data
    clear CaSignal;
    clear GG
    clear GG_TOT
    
    figure();
    title('Individual group trained PCA, unchopped')
for trial = 1:size(Cal{1,group}{1,1},1)
for cell = 1:size(Cal{1,group},2)
CaSignal(trial,:,cell) = tsmovavg(Cal{1,group}{1,cell}(trial,:),'s',4);

end

GG = squeeze(CaSignal(trial,AlignBound,:)); 
TX = size(GG,1);
clear CaSignal;
try
GG_TOT = vertcat(GG_TOT,GG);
catch
    GG_TOT = GG;
end
clear GG;
end

% Run PCA on total concatnated CA data.
[coeff,score] = princomp(GG_TOT);
GG_TOT_tot{group} =GG_TOT;
clear GG_TOT

%%%===[ Plot Indivivually trained PCAs ] ====%%%

% Get scores for each dim
z1 = score(:,1);
x1 = score(:,2);
y1 = score(:,3);

% plot
hold on;
plot(1:length(z1),x1,'r'); plot(1:length(z1),y1,'g'); plot(1:length(z1),z1,'b');


figure();
title('Individual group trained PCA')
for trial = 1:size(Cal{1,group}{1,1},1)
range = (1:TX)+TX*(trial-1);
z1a = score(range,1); x1a = score(range,2); y1a = score(range,3);
hold on;
plot(1:length(x1a),x1a,'r'); plot(1:length(y1a),y1a,'g'); plot(1:length(z1a),z1a,'b');
end


end

%%%===[ Train PCA on all concatnated data ] ====%%%
FIn = vertcat(GG_TOT_tot{1},GG_TOT_tot{2});
[coeff,score] = princomp(FIn);



% Get scores for each dim
z1 = score(:,1);
x1 = score(:,2);
y1 = score(:,3);
% plot
figure();
title('Unchopped, all PCA')
hold on;
plot(1:length(z1),x1,'r');
plot(1:length(z1),y1,'g');
plot(1:length(z1),z1,'b');




%%% The final cut
A = size(GG_TOT_tot{1},1);
B = size(GG_TOT_tot{2},1);
% C = size(GG_TOT_tot{3},1);

G_final{1} = score(1:A,:);
G_final{2} = score((1+A):(A+B),:);
% G_final{3} = score((1+A+B):(A+B+C),:);


clear z1a
clear x1a
clear y1a
clear w1a

figure();

for group = 1:2;
    
clear range;

for trial = 1:size(Cal{1,group}{1,1},1)
range = (1:TX)+TX*(trial-1);

x1a{group}(trial,:) = G_final{group}(range,4);
y1a{group}(trial,:) = G_final{group}(range,5);
z1a{group}(trial,:) = G_final{group}(range,6);
w1a{group}(trial,:) = G_final{group}(range,7);

hold on;

subplot(1,2,group)
hold on;
plot((1:length(x1a{group}(trial,:)))/25,zscore(x1a{group}(trial,:)),'r');
plot((1:length(y1a{group}(trial,:)))/25,zscore(y1a{group}(trial,:)),'g');
plot((1:length(z1a{group}(trial,:)))/25,zscore(z1a{group}(trial,:)),'b');
% plot(1:length(w1a),w1a,'m');
% ylim([-10 50]);

end

end

figure();
hold on;
G{1} = zscore(x1a{1}');
G{2} = zscore(y1a{1}');
G{3} = zscore(z1a{1}');
G{4} = zscore(x1a{2}');
G{5} = zscore(y1a{2}');
G{6} = zscore(z1a{2}');
scrapPlot(G);

Siz = (1:size(AlignBound,2))/25;

figure(); 
subplot(4,1,1)
hold on;
plot(Siz,x1a{1}(:,:)','r');
plot(Siz,x1a{2}(:,:)','g');
% plot(Siz,x1a{3}(:,:)','b');
subplot(4,1,2)
hold on;
plot(Siz,y1a{1}(:,:)','r');
plot(Siz,y1a{2}(:,:)','g');
% plot(Siz,y1a{3}(:,:)','b');
subplot(4,1,3)
hold on;
plot(Siz,z1a{1}(:,:)','r');
plot(Siz,z1a{2}(:,:)','g');
% plot(Siz,z1a{3}(:,:)','b');

subplot(4,1,4)
hold on;
plot(Siz,w1a{1}(:,:)','r');
plot(Siz,w1a{2}(:,:)','g');
% plot(Siz,w1a{3}(:,:)','b');



figure(); 
subplot(4,1,1)
hold on;
plot(Siz,mean(x1a{1}(:,:)),'r');
plot(Siz,mean(x1a{2}(:,:)),'g');
% plot(Siz,mean(x1a{3}(:,:)),'b');
subplot(4,1,2)
hold on;
plot(Siz,mean(y1a{1}(:,:)),'r');
plot(Siz,mean(y1a{2}(:,:)),'g');
% plot(Siz,mean(y1a{3}(:,:)),'b');
subplot(4,1,3)
hold on;
plot(Siz,mean(z1a{1}(:,:)),'r');
plot(Siz,mean(z1a{2}(:,:)),'g');
% plot(Siz,mean(z1a{3}(:,:)),'b');

subplot(4,1,4)
hold on;
plot(Siz,mean(w1a{1}(:,:)),'r');
plot(Siz,mean(w1a{2}(:,:)),'g');
% plot(Siz,mean(w1a{3}(:,:)),'b');
    
    
output.x1a = x1a;
output.y1a = y1a;
output.z1a = z1a;
output.w1a = w1a;






