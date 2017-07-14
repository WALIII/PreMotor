function [Cal, Aln] = FS_Premotor_modelSort(calcium, align, idx)
% Sort data for Nathan's model


% manually define the clusters:
t1 = 2:73;
t2 = 74:150;
t3 = 151:345;

for i = 1:size(calcium,2);
   Cal{1}{1,i} =  calcium{i}(idx(t2),:);
   Cal{2}{1,i} =  calcium{i}(idx(t1),:);
   Cal{3}{1,i} =  calcium{i}(idx(t3),:);
end
Aln{1} = align;
Aln{2} = align;
Aln{3} = align;

% check it over:

figure(); plot(Cal{1}{1,1}');