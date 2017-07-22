
function [calcium, DATA_D, song_r, song, align] =  FS_PreMotor(roi_ave,TEMPLATE)
% run on data extracted from base directory, to aligne to the first
% detected song

% 05.26.17
% WAL3

warning off

counter = 1;

for i = 1:size((roi_ave.analogIO_dat),2)
trial = i;
fs = 48000;
[song_start, song_end, score_d] = find_audio(roi_ave.analogIO_dat{i}, TEMPLATE, fs, 'match_single', false);
%alignment
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
song_start = song_start(:); % If 'last' replace ':' w/ with 'end'
catch
    continue
end
I2 = 2:size(song_start,1); % If Not First replace '1' w/ 2

if I2 == 0;
    disp(' no songs detected, skipping')
    continue
end



for ii = I2;%1: size(song_start,2)
    score_d;
    if score_d(ii)>1000000
        continue
    else

            idx1=song_start(ii); %time in seconds

            [~,loc1]= min(abs(roi_ave.interp_time{i}-idx1));
            
            startT{counter} = loc1; % align to this frame
            
              
            g = zftftb_rms(roi_ave.analogIO_dat{i}(idx1*fs:end),48000);
            g2 = zftftb_rms(roi_ave.analogIO_dat{i}(1:idx1*fs),48000);

            song{counter} = g';
            song2{counter} = g2';
            song_r1{counter} = roi_ave.analogIO_dat{i}(idx1*fs:end)';
            song_r2{counter} = roi_ave.analogIO_dat{i}(1:idx1*fs)';
            
            clear g;
            clear g2;
         

            
            % create and concat, 2 matrixes
            % start:
            
            for cell = 1:size(roi_ave.interp_dff,1)
            DATA_D{counter}(cell,:) =  (roi_ave.interp_raw{cell,trial});
            %padding
            DATA_D{counter}(cell,1:10)= DATA_D{counter}(cell,11);
            end
            
%             DATA_D{counter} = bsxfun(@minus, DATA_D{counter}, mean(DATA_D{counter}));
%             
            % Zscore data ( needs to be done after mean subtraction)
             for cell = 1:size(roi_ave.interp_dff,1)
            %padding
            DATA_D{counter}(cell,:)= zscore(DATA_D{counter}(cell,:));
          %  DATA_D{counter}(cell,:)= (DATA_D{counter}(cell,:) -min(min((DATA_D{counter}(cell,:)))));
            end
            
            
            
          clear CAL_start;
          clear CAL_end;
          counter = counter+1;
    end
end
end

disp('catch');


for cell = 1:size(roi_ave.interp_dff,1)
for  trial = 1:size(DATA_D,2);

            CAL_start{cell}{trial} = DATA_D{trial}(cell,1:startT{trial} );
            CAL_end{cell}{trial} = DATA_D{trial}(cell,startT{trial}:end);
end
end




for cell = 1:size(roi_ave.interp_dff,1);
    
            % MAke matrix END
            % very simple example
% assumes each entry in a is a row vector
a = CAL_start{cell};
b = CAL_end{cell};

% figure out longest
max_length = max(cellfun(@length, a));
max_length2 = max(cellfun(@length, b));
align = max_length;
% extend
a_extended = cellfun(@(x) [zeros(1, max_length - length(x)) x], a, 'UniformOutput', false);
b_extended = cellfun(@(x) [x zeros(1, max_length2 - length(x))], b, 'UniformOutput', false);

% concatenate
a_matrix = cat(1, a_extended{:});
b_matrix = cat(1, b_extended{:});
clear Tally

 calcium{cell} = cat(2,a_matrix,b_matrix);
end


%concat songs

% for trials = 1:10
    
            % MAke matrix END
            % very simple example
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

% extend
a_extended = cellfun(@(x) [x zeros(1, max_length - length(x))], a, 'UniformOutput', false);
b_extended = cellfun(@(x) [zeros(1, max_length2 - length(x)) x], b, 'UniformOutput', false);
c_extended = cellfun(@(x) [x zeros(1, max_length3 - length(x))], c, 'UniformOutput', false);
d_extended = cellfun(@(x) [zeros(1, max_length4 - length(x)) x], d, 'UniformOutput', false);


% concatenate
clear song
clear song2

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
% end



% index into calcium data


% add zeros to padd everything imaging data

%

