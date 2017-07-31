function CONTEXT_FIGURE2

%load input data, or load in lr28, 

% Recreate data:

% load('/Users/ARGO/Dropbox/Shared/Manuscripts/HVC_Context/data/raw_data/LR28/roi/ave_roi.mat')
% 
% % first song, edit start sequence of this function
% [calcium1, DATA_D1, song_r1, song1, align1] =  FS_PreMotor(roi_ave,TEMPLATE(1:end));
% % all but the first song,
% [calcium2, DATA_D2, song_r2, song2, align2] =  FS_PreMotor(roi_ave,TEMPLATE(1:end));



% align spectrograms
F2_1(song_r1,song_r2,align1,align2);