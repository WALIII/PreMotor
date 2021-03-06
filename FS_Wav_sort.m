function [WAVcell] =  FS_Wav_sort(Motif_ind,align,song_r)


% Seperate Data, if it is first, last, only, or middle.
    C_first = find( Motif_ind(2,:)>1 &  Motif_ind(1,:) == 1);
    C_only  = find( Motif_ind(2,:) == 1 & Motif_ind(1,:)==1);
    C_last  = find( Motif_ind(2,:)>1 & Motif_ind(2,:) == Motif_ind(1,:));
    C_middle = find( Motif_ind(2,:)>2 & Motif_ind(1,:) >1 & Motif_ind(1,:) < Motif_ind(2,:));
    
    

A_1{1} = align/48000*25;
A_1{2} = align/48000*25;

sT = 0.2;
eT = 1.1;

counter = 1;
for i = C_first
 WAV_1{counter} = song_r(i,((A_1{1})/25-sT)*48000:(A_1{1}/25+eT)*48000)';
counter= counter+1;
end

WAVcell{1} = WAV_1;

counter = 1;
for i = C_only
WAV_o{counter} = song_r(i,((A_1{2})/25-sT)*48000:(A_1{2}/25+eT)*48000)';
counter= counter+1;
end
try WAVcell{2} = WAV_o; catch;  WAVcell{2} = 0; end;
 
counter = 1;
for i = C_last
WAV_l{counter} = song_r(i,((A_1{2})/25-sT)*48000:(A_1{2}/25+eT)*48000)';
counter= counter+1;
end
WAVcell{3} = WAV_l;
 
counter = 1;
for i = C_middle
WAV_m{counter} = song_r(i,((A_1{2})/25-sT)*48000:(A_1{2}/25+eT)*48000)';
counter= counter+1;
end
 WAVcell{4} = WAV_m;