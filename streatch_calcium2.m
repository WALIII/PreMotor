

function [Wcalcium, stretch] = streatch_calcium2(calcium,align,startT,endT)

% onset = 5;
% endset = 5;


G(1,:) = 1- abs(endT{1}-startT{1}- max(endT{1}-startT{1}));
G(2,:) = endT{1}-startT{1};

for trial = 1:size(startT{1}',1)

% x = -startT{1}(trial)):(1/25):25-endT{1}(trial);



NG = (0:(1/25):1); % want to be even
OG = (NG./ G(1,trial)); % original was compressed, like this % 1 = longest, unchaged. 0.5 = most streatched.
%offset
 %NG = NG+ (max(OG) - max(NG))/2; 
NG = NG- (mean(OG) - mean(NG)); % apply streatches to begining

stretch{trial}.Old = NG;
stretch{trial}.New = OG;




for cells = 1:size(calcium,2)
c_vect(:,cells) = (calcium{cells}(trial,(align:align+25)));
end

% now, streatch the vector
ct_vect(trial,:,:) = c_vect(:,:);

v = (c_vect(:,:));
% xq = WARPED_TIME{1}{trial}(2,:);


t2 = interp1(OG,v,NG); %new data
%sc_vect(trial,:,:) = resample(t2,25,4800);
sc_vect(trial,:,:) = t2;


clear t_vect x temp

end


close all

figure()
% Works
cells = 5;
subplot(121)
hold on;
imagesc(ct_vect(:,:,cells));
title('un-warped Ca');
subplot(122)
imagesc(flip(sc_vect(:,:,cells)));
title('Warped Ca');





% Downsample

% export new vector: (stich away the NANs

for cells = 1:size(calcium,2)
    for trial = 1:size(calcium{1},1)
        % 1. find nans, index into the last NAN
        t = sc_vect(trial,:,cells);
        [rep1] = min(find(isnan(t) == 0));
        [rep2] = max(find(isnan(t) == 0));
        % 2.( add zeros to front of Calcium vector
       
        if isempty(rep1)  && rep2 == size(sc_vect(trial,:,cells),2)
            Wcalcium{cells}(trial,:) = calcium{cells}(trial,:);
        else
        %front end
        front = cat(2, ones(1,rep1-1)+calcium{cells}(trial,1), calcium{cells}(trial,1:align-1));
        middle = sc_vect(trial,rep1:rep2,cells);
        last = cat(2,calcium{cells}(trial,(align+size(sc_vect(trial,:,cells),2)):end),ones(1,size(sc_vect(trial,:,cells),2)-(rep2))); 
        %stitch
Wcalcium{cells}(trial,:) = cat(2,front, middle, last);
clear front middle last rep
        end
        end
    end
end


