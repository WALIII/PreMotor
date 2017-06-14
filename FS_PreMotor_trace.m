function FS_PreMotor_trace(calcium)

figure(); 
hold on;
counter = 1;

shift = 2;
for cell = 1:size(calcium,2);
G = calcium{cell};

data = tsmovavg(G(:,1:end),'s',4);
data(:,1:4) = 0;

 
L = size(data,2);
se = std(data)/2;%sqrt(length(data));
mn = mean(data)+counter*shift;


col = lines(size(calcium,2));

plot(mn,'Color',col(cell,:));
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(cell,:)); alpha(.5)
set(h,'EdgeColor','None');


counter = counter+1;
end
line([206 206],[0 20]);
line([260 260],[0 20]);

