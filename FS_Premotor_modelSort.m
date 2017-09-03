function [Cal, Aln, index_split] = FS_Premotor_modelSort(calcium, align, idx)
% Sort data for Nathan's model


% manually define the clusters:
%t1 = 1:7;
t1 = 1:13;
t2 = 14:44;
t3 = [45:159,184:274];
index_split{1} = t1;
index_split{2} = t2;
index_split{3} = t3;


for i = 1:size(calcium,2);
for ii = 1:size(index_split,2)
   Cal{ii}{1,i} =  calcium{i}(idx(index_split{ii}),:);
   Aln{ii} = align;
end

end


% check it over:
figure();
hold on;
plot(Cal{1}{1,1}','r');
plot(Cal{2}{1,1}','b');
