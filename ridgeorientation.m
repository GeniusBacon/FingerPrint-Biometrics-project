% RIDGEORIENT - Estimates the local orientation of ridges in a fingerprint
% Arguments:  im                - A normalised input image.
%             gradientsigma     - Sigma of the derivative of Gaussian
%                                 used to compute image gradients.
%             blocksigma        - Sigma of the Gaussian weighting used to
%                                 sum the gradient moments.
%             orientsmoothsigma - Sigma of the Gaussian used to smooth
%                                 the final orientation vector field.
% 
% Returns:    orientim          - The orientation image in radians.
%                                 Orientation values are +ve clockwise
%                                 and give the direction *along* the
%                                 ridges.
%             reliability       - Measure of the reliability of the
%                                 orientation measure.  This is a value
%                                 between 0 and 1. I think a value above
%                                 about 0.5 can be considered 'reliable'.

function [Gx,Gy,orientim, reliability] = ...
             ridgeorientation(im, gradientsigma, blocksigma, orientsmoothsigma)
        
    [rows,cols] = size(im);
    
    % Calculate image gradients.
    sze = fix(6*gradientsigma);   if ~mod(sze,2); sze = sze+1; end
    f = fspecial('gaussian', sze, gradientsigma); % Generate Gaussian filter.
    [fx,fy] = gradient(f);                        % Gradient of Gausian.
    
    Gx = filter2(fx, im); % Gradient of the image in x
    Gy = filter2(fy, im); % ... and y
    
    % Estimate the local ridge orientation at each point by finding the
    % principal axis of variation in the image gradients.
   
    Gxx = Gx.^2;
    Gxy = Gx.*Gy;
    Gyy = Gy.^2;
    
    % Now smooth the covariance data to perform a weighted summation of the
    % data.
    sze = fix(6*blocksigma);   if ~mod(sze,2); sze = sze+1; end    
    f = fspecial('gaussian', sze, blocksigma);
    Gxx = filter2(f, Gxx); 
    Gxy = 2*filter2(f, Gxy);
    Gyy = filter2(f, Gyy);
    
    denom = sqrt(Gxy.^2 + (Gxx - Gyy).^2) + eps;
    sin2theta = Gxy./denom;            % Sine and cosine of doubled angles
    cos2theta = (Gxx-Gyy)./denom;
       
    sze = fix(6*orientsmoothsigma);   if ~mod(sze,2); sze = sze+1; end    
    f = fspecial('gaussian', sze, orientsmoothsigma);    
    cos2theta = filter2(f, cos2theta); % Smoothed sine and cosine of
    sin2theta = filter2(f, sin2theta); % doubled angles
    
    orientim = pi/2 + atan2(sin2theta,cos2theta)/2;

    
    Imin = (Gyy+Gxx)/2 - (Gxx-Gyy).*cos2theta/2 - Gxy.*sin2theta/2;
    Imax = Gyy+Gxx - Imin;
    reliability = 1 - Imin./(Imax+.001);
    reliability = reliability.*(denom>.001);
    
%     GxMask = double(Gx).*double(mask);
%     GyMask = double(Gy).*double(mask);
%     DMask  = double(D) .*double(mask);
%     [x,y,u,v] = directionmap(DMask, 6, Iseg);
%     CMask = double(C).*double(mask);
end