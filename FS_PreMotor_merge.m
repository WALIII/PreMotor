function [total] = FS_PreMotor_merge(input)
% input = {'LYY_10_06_16.mat','LYY_10_07_16.mat','LYY_10_08_16.mat','LYY_10_09_16.mat'}
% Built from FS_merge_data

% WALIII

for i = 1:size(input,2)

load(input{i},'roi_ave');


A = exist('total')
if A<1;
total.analogIO_dat = roi_ave.analogIO_dat;
total.analogIO_time = roi_ave.analogIO_time;
total.interp_time = roi_ave.interp_time;
total.motif = roi_ave.motif;
total.interp_dff = roi_ave.interp_dff;
total.interp_raw = roi_ave.interp_raw;
total.filename = roi_ave.filename;
% total.directed = directed;
% total.undirected = undirected;
else
    
total.analogIO_dat = horzcat(total.analogIO_dat,roi_ave.analogIO_dat);
total.analogIO_time = horzcat(total.analogIO_time,roi_ave.analogIO_time);
total.interp_time = horzcat(total.interp_time,roi_ave.interp_time);
total.motif = horzcat(total.motif,roi_ave.motif);
total.interp_dff = horzcat(total.interp_dff,roi_ave.interp_dff);
total.interp_raw = horzcat(total.interp_raw,roi_ave.interp_raw);
total.filename = horzcat(total.filename,roi_ave.filename);
% total.directed = horzcat(total.directed,directed);
% total.undirected = horzcat(total.undirected,undirected); 
end
end


% Directed = total.directed;
% Undirected = total.undirected;





