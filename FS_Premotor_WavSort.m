function [song, song_r, align]= FS_Premotor_WavSort(WAV,TEMPLATE)
% input wav files, export sorted WAVs for figure one of Context paper
% Eventually integrate as a subfunction of FS_Premotor.m


% PRE-Flight:
% %Run in the .mov directory:
% >> FS_AudioExtract
% %CD into the mav foldeder and run:
% >> WAV = CY_Get_wav
% %May be usefull to concat many days woth of songs


% WALIII
% d06.08.17

% Initial Params:
fs = 48000;
counter = 1;
cutoff = 2250;

for i = 1:size((WAV),2)
trial = i;

% make time vector
time{i} = (1:size((WAV{i}),1))/fs;

warning('off','all')
[song_start, song_end, score_d] = find_audio(WAV{i}, TEMPLATE, fs, 'match_single', false);

try
score_T = [score_d score_T];
catch
    score_T = score_d;
end
%%%%%%%%%%%%{ ALL }%%%%%%%%%%
% I2 = 1: size(song_start,2)

%%%%%%%%%%%%{ SONG TIME DIFFERENCES }%%%%%%%%%%
% X = diff(song_start);
% I = find(X > 1.2);
% I2 = horzcat(1,I+1);

%%%%%%%%%%%%{ If First, Second, or Last }%%%%%%%%%%
try
song_start = song_start(1); % If 'last' replace ':' w/ with 'end'
catch
    continue
end
I2 = 1:size(song_start,1) % If Not First replace '1' w/ 2

if I2 == 0;
    disp(' no songs detected, skipping')
    continue
end



for ii = I2%1: size(song_start,2)
    score_d;
    if score_d(ii)>cutoff;
        continue
    else

            idx1=song_start(ii); %time in seconds

            [~,loc1]= min(abs(time{i}-idx1));        
            startT{counter} = loc1; % align to this frame
              
            g = zftftb_rms(WAV{i}(idx1*fs:end),48000);
            g2 = zftftb_rms(WAV{i}(1:idx1*fs),48000);
            song{counter} = zscore(g');
            song2{counter} = zscore(g2');
            song_r1{counter} = WAV{i}(idx1*fs:end)';
            song_r2{counter} = WAV{i}(1:idx1*fs)';
            
            clear g;  clear g2;

          counter = counter+1;
    end
end
end

disp('Concatonating Songs');

% assumes each entry in a is a row vector
a = song;
b = song2;
c = song_r1;
d = song_r2;

% figure out longest
max_length = max(cellfun(@length, a));
max_length2 = max(cellfun(@length, b));
max_length3 = max(cellfun(@length, c));
max_length4 = max(cellfun(@length, d));
align = max_length2;

% extend
a_extended = cellfun(@(x) [x zeros(1, max_length - length(x))], a, 'UniformOutput', false);
b_extended = cellfun(@(x) [zeros(1, max_length2 - length(x)) x], b, 'UniformOutput', false);
c_extended = cellfun(@(x) [x zeros(1, max_length3 - length(x))], c, 'UniformOutput', false);
d_extended = cellfun(@(x) [zeros(1, max_length4 - length(x)) x], d, 'UniformOutput', false);

% concatenate
clear song; clear song2;

song1 = cat(1, a_extended{:});
song2 = cat(1, b_extended{:});
song3 = cat(1, c_extended{:});
song4 = cat(1, d_extended{:});

song = cat(2,song2,song1);
song_r = cat(2,song4,song3);

for n = 1:size(song,1)
    song_all(n,:) = downsample(song(n,:),1000);
end
clear song;
song = song_all;


figure(); histogram(score_T,20);
end


