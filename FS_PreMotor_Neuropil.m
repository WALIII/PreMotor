function [out] = FS_PreMotor_Neuropil(ROI)
% Extract Neuropil

% d09/24/17
% WAL3


% Make indexes for the ROI coordinates
  for i = 1:size(ROI.coordinates,2);
  if i == 1;
    X2 = [ROI.coordinates{i}(:,2),ROI.coordinates{i}(:,1)];
    else
    X = [ROI.coordinates{i}(:,2),ROI.coordinates{i}(:,1)];
    X2 = cat(1,X2,X);
  end
  end

  % Diagnostics
  XA = ROI.reference_image;
  XA(sub2ind( size(XA), X2(:,1), X2(:,2))) = NaN;
  figure();
  imagesc(XA);

% Run in mat directory
  mov_listing=dir(fullfile(pwd,'*.mat'));
  mov_listing={mov_listing(:).name};
  filenames=mov_listing;

  for i=1:length(mov_listing)

  load(fullfile(pwd,mov_listing{i}),'video');

[out_mov, n] = FS_Format(video.frames,1);
disp('New file');

for ii = 1:size(out_mov,3)
    temp = out_mov(:,:,ii);
out.Bgnd{i}(:,ii) = mean(mean(temp));
temp(sub2ind( size(temp), X2(:,1), X2(:,2))) = NaN;
out.Npil{i}(:,ii) = mean(mean(temp));
clear temp;
end

clear out_mov;
clear video;

end
