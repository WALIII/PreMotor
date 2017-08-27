function [Syl, indX] =  FS_Premotor_selectMotif(WARPED_audio_d,WARPED_TIME_d,indX)

% For motif analysis, select motifs, and get sylable data

sp = 0;
if nargin < 3

[C,F,T,IMAGE1] = FS_Premotor_AvgSpectrogram(WARPED_audio_d',1,0.51);

prompt = 'How many syllables are there?';
x = input(prompt)

else
    sp = 1;
    x = size(indX,2);
end


for i = 1:x; % for all syllables
    if sp ==0;
    disp('Select a syllable:  ')
rect = getrect; %[xmin ymin width height]
indX{i} = rect;
    else
        rect = indX{i};
    end

% Cut out sylabe
for ii = 1:size(WARPED_audio_d,2)% for all trials
Syl{i}.audio_data(:,ii) = WARPED_audio_d(rect(1)*48000:(rect(3)+rect(1))*48000,ii);



[cw{1} index{1}] = min(abs(WARPED_TIME_d{ii}(1,:)-rect(1)))
[cw{2} index{2}] = min(abs(WARPED_TIME_d{ii}(1,:)-(rect(3)+rect(1))))

% CV{1} = WARPED_TIME_d{ii}(1,index{1}); % start
% CV{2} = WARPED_TIME_d{ii}(1,index{2}); % end

try
Syl{i}.audio_time{ii} = WARPED_TIME_d{ii}(:,index{1}:index{2}); % send both vectors
catch
    disp('&')
end

end
end



% to do:

% Propt user to calculate SDIs using Nathan's method:

prompt = 'Do you want more? y/n : ';
str = input(prompt,'s');
if str== 'y'
    % Calculate SDIs for the entire song
[Gconsensus,F,T] = CY_Get_Consensus(WARPED_audio_d);

% Break up motif SDI information:
    for i = 1:x; % for all motifs,
        rect = indX{i};
        % Get index data
        %cvrsn = ??; % conversion from units of T to time
[cw{1} index{1}] = min(abs(T-rect(1)));
[cw{2} index{2}] = min(abs(T-(rect(3)+rect(1))));

for ii = 1:size(WARPED_audio_d,2)
Syl{i}.SDI{ii} = Gconsensus{1}(:,index{1}:index{2},ii);
end
    end

else
    disp('nope, not today...')
end
