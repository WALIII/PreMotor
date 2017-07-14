function FS_PreMotor_trace_comp(Cal, Alp)

figure(); 

hold on;
for iii = 1:size(Cal,2);
counter = 1;
shift = 5;

calcium = Cal{iii};

for cell =1:size(calcium,2); %[16 23 25 41 4 10 11 14 15 19 26 36 37 48 49];% [16 25 33 36 37 41 56 59]%1:size(calcium,2); %[16 25 33 36 37 41 56 59] %[6 14 15 17 19 35 38 53]
G = calcium{cell};
 %16 23 25 41 4
 %10 11 14 15 19 26 36 37 48 49

data = tsmovavg(G(:,1:end),'s',4);
data(:,1:4) = 0;

extend = zeros(size(G,1),(Alp{end}-Alp{iii}));
data = horzcat(extend,data);


L = size(data,2);
se = std(data)/2;%sqrt(length(data));
mn = mean(data)+counter*shift;


col = hsv(size(Cal,2));
h = fill([1:L L:-1:1],[mn-se fliplr(mn+se)],col(iii,:)); alpha(0.5);
plot(mn,'Color',col(iii,:));


set(h,'EdgeColor','None');


counter = counter+1;
end
line([Alp{end} Alp{end}],[0 counter*shift],'color','r');
line([Alp{end}+10 Alp{end}+10],[0 counter*shift]);
line([Alp{end}+30 Alp{end}+30],[0 counter*shift]);

% line([6.8*25 6.8*25],[0 counter*shift]);
% line([7.14*25 7.14*25],[0 counter*shift]);
% line([7.77*25 7.77*25],[0 counter*shift]);
% line([8.38*25 8.38*25],[0 counter*shift]);

end
xlim([Alp{end}-30 Alp{end}+80])
