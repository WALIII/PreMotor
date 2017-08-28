function [Syl, indX] =  FS_Premotor_selectMotif(WARPED_audio,WARPED_TIME,indX)

% For motif analysis, select motifs, and get sylable data

sp = 0;
if nargin < 3

[C,F,T,IMAGE1] = FS_Premotor_AvgSpectrogram(WARPED_audio{1}',1,0.51);

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
for iii = 1:size(WARPED_audio,2) % For all motif types
for ii = 1:size(WARPED_audio{iii},2)% for all trials
Syl{i}.audio_data{iii}(:,ii) = WARPED_audio{iii}(rect(1)*48000:(rect(3)+rect(1))*48000,ii);

[cw{1} index{1}] = min(abs(WARPED_TIME{iii}{ii}(1,:)-rect(1)))
[cw{2} index{2}] = min(abs(WARPED_TIME{iii}{ii}(1,:)-(rect(3)+rect(1))))

% CV{1} = WARPED_TIME_d{ii}(1,index{1}); % start
% CV{2} = WARPED_TIME_d{ii}(1,index{2}); % end

try
Syl{i}.audio_time{iii}{ii} = WARPED_TIME{iii}{ii}(:,index{1}:index{2}); % send both vectors
catch
    disp('&')
end

end
end
end



% to do:

% Propt user to calculate SDIs using Nathan's method:

prompt = 'Do you want more? y/n : ';
str = input(prompt,'s');
if str== 'y'
    % Calculate SDIs for the entire song

    for iii = 1:size(WARPED_audio,2) % For all motif types
[Gconsensus,F,T] = CY_Get_Consensus(WARPED_audio{iii});

% Break up motif SDI information:
for i = 1:x; % for all motifs,
        rect = indX{i};
        % Get index data
        %cvrsn = ??; % conversion from units of T to time
[cw{1} index{1}] = min(abs(T-rect(1)));
[cw{2} index{2}] = min(abs(T-(rect(3)+rect(1))));

for ii = 1:size(WARPED_audio{iii},2)
Syl{i}.SDI{iii}{ii} = Gconsensus{1}(:,index{1}:index{2},ii);
end

% calculate SIM score
[Syl{i}.sim_score{iii}, Syl{i}.vector_score{iii}] = FS_song_dff(Syl{i}.SDI{iii});
    end
  end

else
    disp('nope, not today...')
end
