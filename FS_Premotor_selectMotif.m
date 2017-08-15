function Syl =  FS_Premotor_selectMotif(WARPED_audio_d,WARPED_TIME_d)

% For motif analysis, select motifs, and get sylable data

[C,F,T,IMAGE1] = FS_Premotor_AvgSpectrogram(WARPED_audio_d',1,0.51);

prompt = 'How many syllables are there?';
x = input(prompt)


for i = 1:x; % for all syllables
    disp('Select a Syl')
rect = getrect; %[xmin ymin width height]

% Cut out sylabe
for ii = 1:size(WARPED_audio_d,2)% for all trials
Syl{i}.audio_data(:,ii) = WARPED_audio_d(rect(1)*48000:(rect(3)+rect(1))*48000,ii);


% TO DO: is it index 1 or 2? * change (2,:)
[cw{1} index{1}] = min(abs(WARPED_TIME_d{ii}(2,:)-rect(1)))
[cw{2} index{2}] = min(abs(WARPED_TIME_d{ii}(2,:)-(rect(3)+rect(1))))

CV{1} = WARPED_TIME_d{ii}(2,index{1}); % start
CV{2} = WARPED_TIME_d{ii}(2,index{2}); % end

try
Syl{i}.audio_time(:,ii) = WARPED_TIME_d{ii}(:,CV{1}:CV{2}); % send both vectors
catch
    disp('&')
end

end
end

