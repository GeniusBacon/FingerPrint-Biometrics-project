% Segmentation function that segments the pixels above the specified threshold

% The image is normalised to have zero mean, unit standard
% deviation prior to performing this process so that the threshold you
% specify is relative to a unit standard deviation.

% Breaks the image up into blocks of size blksze x blksze and
% evaluates the standard deviation in each region.

function [normim, mask, maskind] = ridgesegment(im, blksze, thresh)
    
    im = normalise(im,0,1);  % normalise to have zero mean, unit std dev
    
    fun = inline('std(x(:))*ones(size(x))');
    
    stddevim = blkproc(im, [blksze blksze], fun);
    
    mask = stddevim > thresh;
    %figure, imshow(mask);
    maskind = find(mask);
    
    % Renormalise image so that the *ridge regions* have zero mean, unit
    % standard deviation.
    im = im - mean(im(maskind));
    normim = im/std(im(maskind));    
   
end
