function [featureRidge,featureBifurcation]=MinutiaeExtraction(skeleton,mask2)
[sizeX, sizeY] = size(skeleton);
Im = ~xor(skeleton, mask2);
% Window
WindowSize = 3;
window = zeros(WindowSize);
border = floor(WindowSize/2);
center = border+1;
% Temporary data to work with
row = sizeX + 2*border;
col = sizeY + 2*border;
double temp(row,col);
temp = zeros(row,col);
temp( (center):(end-border), (center):(end-border) ) = Im(:,:);
% Minutiae containers
featureRidge       = zeros(row,col);
featureBifurcation = zeros(row,col);
for x = (center+10):(sizeX+border-10)
    for y = (center+10):(sizeY+border-10)
        % fill in window with values from temp
        e = 1;
        for k = x-border:x+border
            f = 1;
            for l = y-border:y+border
                window(e,f) = temp (k,l);
                f = f+1;
            end
            e=e+1; 
        end
        if (window(center,center) == 0)
            
            featureRidge(x,y)       = sum(sum(~window));
            featureBifurcation(x,y) = sum(sum(~window));
        end
    end
end
% Resize area
featureRidge = featureRidge(1+border:end-border,1+border:end-border);
featureBifurcation = featureBifurcation(1+border:end-border,1+border:end-border);
end