function [coeff score] = FS_PreMotor_PCA2(Cal,A)

% concat evertthing, leke nathan talked about

A{1};
AlignBound = 150:200;%Alignment Boundries ((Aln{1}-20):(Aln{1}+80))


for group = 1:2;%1:size(Cal,2) % Each 'Group' is a subset of aligned data
    clear CaSignal;
    clear GG
   

for trial = 1:size(Cal{1,group}{1,1},1)
for cell = 1:size(Cal{1,group},2)
CaSignal(trial,:,cell) = tsmovavg(Cal{1,group}{1,cell}(trial,:),'s',2);

end

GG = squeeze(CaSignal(trial,AlignBound,:)); 

GG2 = GG(:);

CaTot(:,trial) = GG(:);
clear CaSignal;
end

% TX = size(GG,1);

try
GG_TOT = horzcat(GG_TOT,CaTot);
catch
GG_TOT = CaTot;
end
clear GG;
end

% Run PCA on total concatnated CA data.
[coeff,score] = princomp(GG_TOT);
% GG_TOT_tot{group} =GG_TOT;

clear CaTot;


for i = 1:3
XX(:,i) = score(i,1:6);
XX2(:,i) = score(i,7:12);
XX3(:,i) = score(i,13:18);
end
figure();


% for i = 1:3
% XX(:,i) = score(i,1:19);
% XX2(:,i) = score(i,20:39);
% XX3(:,i) = score(i,40:45);
% end



boxplot([XX(1:6,1), XX2(1:6,1), XX3(1:6,1)]);
title('PCA1')

% figure();
% boxplot([XX(:,2), XX2(:,2), XX3(:,2)]);
% title('PCA2')
% 
% figure();
% boxplot([XX(:,3), XX2(:,3), XX3(:,3)]);
% title('PCA3')


figure(); 
hold on;
plot(XX(:,1),XX(:,2),'r*')
plot(XX2(:,1),XX2(:,2),'g*')
plot(XX3(:,1),XX3(:,2),'b*')
xlabel('PC1');
ylabel('PC2');
% zlabel('PC3');

grid on
end

% 
