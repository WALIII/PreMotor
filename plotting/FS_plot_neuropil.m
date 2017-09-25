function FS_plot_neuropil(BGD)




out.Bgnd = BGD.Bgnd;
out.Npil = BGD.Npil;

counter = 1;
for ii = find([BGD.index{:}] == 0)
MD{counter} = out.Bgnd{ii}(:,16:end)-out.Npil{ii}(:,16:end)-min(out.Bgnd{ii}(:,16:end)-out.Npil{ii}(:,16:end));
D1(counter) = mean(out.Bgnd{ii}(:,10:end)- min(out.Bgnd{ii}(:,10:end)) );
D2(counter) = mean(out.Npil{ii}(:,10:end)- min(out.Npil{ii}(:,10:end)));
%D(ii) = mean(M);
counter = counter+1;

end

counter = 1;
for ii = find([BGD.index{:}] == 1)
MU{counter} = out.Bgnd{ii}(:,16:end)-out.Npil{ii}(:,16:end)-min(out.Bgnd{ii}(:,16:end)-out.Npil{ii}(:,16:end));
U1(counter) = mean(out.Bgnd{ii}(:,10:end)- min(out.Bgnd{ii}(:,10:end)) );
U2(counter) = mean(out.Npil{ii}(:,10:end)- min(out.Npil{ii}(:,10:end)));
%U(ii) = mean(M);
counter = counter+1;
end

figure()
hold on;
h1 = histogram(U2-U1,15)
h2 = histogram(D2-D1,15)


% histogram(C)

h1.Normalization = 'probability';
% h1.BinWidth = 0.3;
h2.Normalization = 'probability';
% h2.BinWidth = 0.3;
