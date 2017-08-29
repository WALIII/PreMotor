function [song, song_r, align,Motif_ind]= FS_Premotor_WavSort(WAV,TEMPLATE)
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
cutoff = 8900;

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


%%%%%%%% { Eliminate low scores} %%%%%%%% 
for iii = 1:size(score_d,2);    
score_d;
    if score_d(iii)>cutoff
        song_start(iii) = 0;
        score_d(iii) = 0;
%         continue
    else
        
    end
end
song_start( song_start==0 )=[];
score_d( score_d==0 )=[];

%%%%%%%%%%%%{ ALL }%%%%%%%%%%
% I2 = 1: size(song_start,2)


%%%%%%%%%%%%{ If First, Second, or Last }%%%%%%%%%%
try
song_start2 = song_start(:); % If 'last' replace ':' w/ with 'end'
sindex = 1:size(song_start,2); %motif number
catch
    continue
end
I2 = 1:size(song_start2,1); % If Not First replace '1' w/ 2
XI2 = I2;

%%%%%%%%%%%%{ OPTIONAL: SONG TIME DIFFERENCES }%%%%%%%%%%
% Now we can index into numbered motifs ( 1st, second, last, etc)
% sinindex = the index of the motif
% I = breaks in motif ( so, the 'last' motif in the run)

X = diff(song_start);
I = find(X > 2.5);
I2 = horzcat(1,I+1);
% end if there are no songs detected....
if I2 == 0;
    disp(' no songs detected, skipping')
    continue
end
% reset motif number, based on gaps...
counter2 = 1;
NN = [I2 size(sindex,2)+1];
for iv = I2
sindex((iv):size(sindex,2)) = 1:(size(sindex,2)-iv+1); % adjust motif index- 
dindex((iv):size(sindex,2)) = NN(counter2+1)-NN(counter2);
counter2 = counter2+1;
end








for ii = XI2%1: size(song_start,2)

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
Motif_ind(1,counter) = sindex(ii);
Motif_ind(2,counter) = dindex(ii); % max number of motifs in bout 
          counter = counter+1;

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


