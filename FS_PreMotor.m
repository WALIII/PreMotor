
function [calcium, DATA_D, song_r, song, align, Motif_ind, BGD, stretch] =  FS_PreMotor(roi_ave,TEMPLATE,directed,undirected)
% run on data extracted from base directory, to aligne to the first
% detected song

% 05.26.17
% 09.28.17 % add linear time warping
% WAL3

disp(' Make sure you set the threshold correctly!');

if nargin < 3
directed = 0;
undirected = 0;
DirectedTrials = 0;
UnDirectedTrials = 1:size(roi_ave.interp_dff,2);
elseif nargin > 3
[DirectedTrials, UnDirectedTrials] = Check_Directed(roi_ave, directed,undirected);
end

warning off
 cutoff = 5000; %LNY39
% cutoff = 6700;% lr28
% cutoff = 3500;
% cutoff = 3200; %LYY
 % cutoff = 4000; %LR33
% cutoff = 5000% LR77
% cutoff = 7200% LR5lblk60
%cutoff = 2*10e3% lny13
% cutoff = 3.9*10e3; % lny18
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

%%%%%%%% { Eliminate low scores} %%%%%%%%
for iii = 1:size(score_d,2);
score_d;
    if score_d(iii)>cutoff
        song_start(iii) = 0;
        song_end(iii) = 0;
        score_d(iii) = 0;
%         continue
    else

    end
end
song_end( song_start==0 )=[];
song_start( song_start==0 )=[];
score_d( score_d==0 )=[];


%%%%%%%%%%%%{ ALL }%%%%%%%%%%
% I2 = 1: size(song_start,2)

%%%%%%%%%%%%{ SONG TIME DIFFERENCES }%%%%%%%%%%
% X = diff(song_start);
% I = find(X > 1.2);
% I2 = horzcat(1,I+1);

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
I = find(X > 1);
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
    score_d;



            idx1=song_start(ii); %time in seconds

            [~,loc1]= min(abs(roi_ave.interp_time{i}-idx1));
            
            remainder{counter} = roi_ave.interp_time{i}(loc1)-idx1; % this is the offset
           
            roi_ave.interp_time{i}(loc1);
            
            % get offset 
            
            
           
            startT{counter} = loc1; % align to this frame
            % save these for time warping later...
           start_time{1}(counter) = song_start(ii);
           end_time{1}(counter) = song_end(ii);

            g = zftftb_rms(roi_ave.analogIO_dat{i}(idx1*fs:end),48000);
            g2 = zftftb_rms(roi_ave.analogIO_dat{i}(1:idx1*fs),48000);

            song{counter} = g';
            song2{counter} = g2';
            song_r1{counter} = roi_ave.analogIO_dat{i}(idx1*fs:end)';
            song_r2{counter} = roi_ave.analogIO_dat{i}(1:idx1*fs)';

            clear g;
            clear g2;
            Motif_ind(1,counter) = sindex(ii);
            Motif_ind(2,counter) = dindex(ii); % max number of motifs in bout
            Motif_ind(3,counter)  = ismember(i,DirectedTrials); % 1 if directed, 0 if undirected
           % Get time
            Dir_time = roi_ave.filename{i}(12:19); formatIn = 'HH MM SS';
            Motif_ind(4,counter) =  datenum(Dir_time,formatIn)+datenum('00 00 02',formatIn); % time it all went down
           
    
            % create and concat, 2 matrixes
            % start:

            for cell = 1:size(roi_ave.interp_dff,1)
                % OPTIONAL add back in the neuropil
                try
            BGD.Npil{counter} = roi_ave.Npil{trial};
            BGD.Bgnd{counter} = roi_ave.Bgnd{trial};
            BGD.index{counter} = Motif_ind(3,counter);
            
            DATA_D{counter}(cell,:) =  (roi_ave.interp_raw{cell,trial});% -roi_ave.Npil{trial}+ (roi_ave.Npil{trial}(30));
                catch
                    if trial ==1;
                  disp('Warning: Not correcting for neuropil')
                    end
            BGD.Bgnd{counter} = 0;   
            DATA_D{counter}(cell,:) =  (roi_ave.interp_raw{cell,trial});
                end
                

% padding, check for when LED turns on, and replace these!
iii;
    if cell == 1; for ivi = flip(2:30); % only on the first cell for each trial
          if ivi ==2; chk = 12; break; end; % in case LED was allways on;

         if abs(mean(DATA_D{counter}(cell,ivi))- mean(DATA_D{counter}(cell,ivi-1))) < 10
          continue
        else
         chk = ivi;
            break;
    end; end; end;
        
            DATA_D{counter}(cell,1:chk)= DATA_D{counter}(cell,chk+1);

            end
            
            % Add in neuropil and background
            try
            DATA_D{counter}(cell+1,:) =   roi_ave.Npil{trial};
            DATA_D{counter}(cell+2,:) =   roi_ave.Bgnd{trial};
            DATA_D{counter}(cell+1,1:chk) = DATA_D{counter}(cell+1,chk+1);
            DATA_D{counter}(cell+2,1:chk) = DATA_D{counter}(cell+2,chk+1);
            catch
                disp('no npil!')
            end
            


%             DATA_D{counter} = bsxfun(@minus, DATA_D{counter}, mean(DATA_D{counter}));
%
           
             


%%%         Detrend
%          for ixi = 1: size(DATA_D{1},1)
%           DATA_D2{counter}(ixi,:) = detrend(DATA_D{counter}(ixi,:));
%          end
%          
         % remove any common offsets.
         % remove mean, *weighted by the variance (mean/variance)
%          ofst = mean(DATA_D{counter}(:,:))%./var(DATA_D{counter}(:,:));
%          DATA_D{counter} = bsxfun(@minus, DATA_D{counter}, ofst);


         for ixi = 1: size(DATA_D{1},1)
          DATA_D{counter}(ixi,:) = (DATA_D{counter}(ixi,:)-prctile(DATA_D{counter}(ixi,20:end),5))./prctile(DATA_D{counter}(ixi,20:end),5);
          DATA_D{counter}(ixi,:) = DATA_D{counter}(ixi,:)*100; % units are % df/f
         end
%          ofst = smooth(mean(DATA_D{counter}(:,:)));% ./var(diff(DATA_D{counter}(:,:))));
% %
%          DATA_D{counter} = bsxfun(@minus, DATA_D{counter}, ofst');
%%%         Detrend
         
       % Remove common offsets ~ subtract the mean, weighted by the variance (mean/variance)  
         %ofst = mean(DATA_D{counter}(:,:))./var(DATA_D{counter}(:,:));
        % ofst = smooth(mean(DATA_D{counter}(:,:))./var((DATA_D{counter}(:,:))));
%         ofst = smooth(mean(DATA_D{counter}(:,:)));% ./var(diff(DATA_D{counter}(:,:))));
% %
%          DATA_D{counter} = bsxfun(@minus, DATA_D{counter}, ofst');
         
        % Detrend the mean offset.
%            for ixi = 1: size(DATA_D{1},1)
%            DATA_D2{counter}(ixi,:) = detrend(DATA_D{counter}(ixi,:));
%            end
        
         
%DATA_D4{counter} = bsxfun(@minus, DATA_D3{counter}, mean(DATA_D3{counter}));

          
         % Zscore data ( needs to be done after mean subtraction)
            %  for cell = 1:size(roi_ave.interp_dff,1)
            %        DATA_D{counter}(cell,:)= zscore(DATA_D{counter}(cell,:));
            %        % DATA_D{counter}(cell,:)= (DATA_D{counter}(cell,:) -min(min((DATA_D{counter}(cell,:)))));
            % end



          clear CAL_start;
          clear CAL_end;
          counter = counter+1;

end
end

disp('catch');


for cell = 1:size(DATA_D{1},1)%1:size(roi_ave.interp_dff,1)
for  trial = 1:size(DATA_D,2);

    
%=======[ shift to new timescale ]========= %
    
    
    old_vec = 1:length(DATA_D{trial}(cell,:));
    new_vec = old_vec-(remainder{trial}*25);
    
   DATA_Ds{trial}(cell,:)=interp1(old_vec,DATA_D{trial}(cell,:),new_vec,'spline');
     
    
    
            CAL_start{cell}{trial} = DATA_Ds{trial}(cell,1:startT{trial} );
            CAL_end{cell}{trial} = DATA_Ds{trial}(cell,(startT{trial})+1:end); % add +1 or it will have the same value twice...
end
end




for cell = 1:1:size(DATA_D{1},1)%size(roi_ave.interp_dff,1);

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

% clean up calcium

disp ( 'no warping...');
%[Wcalcium, stretch]= streatch_calcium2(calcium,align,start_time,end_time);
% calcium = Wcalcium;
end
% end

