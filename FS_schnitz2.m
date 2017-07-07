function [indX,B,C] = FS_schnitz2(calcium,align,trial)


for i = 1:size(calcium,2)
data(i,:) = calcium{i}(trial,:);
end

% index_ref = cat(1,data.directed,data.undirected);

% for i = 1:Cel;
%     R(i,:) = (var(index_ref(:,:,i),1));
% end


clear G;
clear G2
G = (data);

data= tsmovavg(G(:,1:end),'s',4);
data(:,1:10) = 0;
G = data;



thresh = 0.7;
% sort song aligned data
[maxA, Ind] = max(G(:,align-5:align+30), [], 2);
G2 = G(maxA>thresh,:);
G3 = G(maxA<=thresh,:);
[maxA, Ind] = max(G2(:,align-5:align+30), [], 2);
% sort pre data

[maxA, Ind2] = max(G3(:,1:align), [], 2);
G3 = G(maxA>thresh,:);
G4 = G(maxA<=thresh,:);
[maxA, Ind2] = max(G3(:,1:align), [], 2);

% sort post data
[maxA, Ind3] = max(G4(:,align+35:end), [], 2);

[dummy, index] = sort(Ind); % durring
[dummy, index2] = sort(Ind2); % pre
[dummy, index3] = sort(Ind3); % post

B  = (G2(index, :));
B2  = (G3(index2, :));
B3  = (G4(index3, :));

B4 = vertcat(B2,ones(1,length(B)),B,ones(1,length(B)),B3);


figure();

imagesc((B), [0, 3]);
title('Directed Trials');
ylabel('ROIs');
xlabel('Frames');
hold on;

colormap(hot);

 colorbar

 figure();

imagesc((B4), [0, 3]);
title('Directed Trials');
ylabel('ROIs');
xlabel('Frames');
hold on;
colormap(hot);

