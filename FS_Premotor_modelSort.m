function [Cal, Aln, index_split] = FS_Premotor_modelSort(calcium, align, idx)
% Sort data for Nathan's model


% manually define the clusters:
%t1 = 1:7;
t1 = 1:222;
t2 = 281:488;
index_split{1} = t1;
index_split{2} = t2;


for i = 1:size(calcium,2);
   Cal{1}{1,i} =  calcium{i}(idx(t2),:);
   Cal{2}{1,i} =  calcium{i}(idx(t1),:);
  % Cal{3}{1,i} =  calcium{i}(idx(t3),:);
end
Aln{1} = align;
Aln{2} = align;
%Aln{3} = align;

% check it over:
figure();
hold on;
plot(Cal{1}{1,1}','r');
plot(Cal{2}{1,1}','b');
