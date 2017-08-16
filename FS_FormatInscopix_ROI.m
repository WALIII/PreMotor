function [outROI] = FS_FormatInscopix_ROI(inROI)
% FS_FormatInscopix_ROI.m


  %   Created: 2017/08/11
  %   By: WALIII
  %   Updated: 2017/08/11
  %   By: WALIII

  % spatially Downsample the ROI maps,  so that they fit with the new data size

Ratio = 4/9; % ratio from FS to Inscopix 


for i = 1:size(inROI.coordinates,2)

  % stats
outROI.stats(i).ConvexHull = inROI.stats(i).ConvexHull*(Ratio);
outROI.stats(i).Centroid = inROI.stats(i).Centroid*(Ratio);
outROI.stats(i).Diameter = inROI.stats(i).Diameter*(Ratio);

 % coordinates
outROI.coordinates{i} = unique(round(inROI.coordinates{i}*(Ratio)),'rows') % must round to integer

end

 %type
 outROI.type = 'Image'

 % reference image
 outROI.reference_image = imresize(inROI.reference_image,Ratio);
