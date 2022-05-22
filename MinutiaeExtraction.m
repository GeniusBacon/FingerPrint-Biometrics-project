% The function that operates on the mask and the skeleton to return all
% potential ridge endings or bifurcations


function [potentialRidge,potentialBifurcation, cleanImg]=MinutiaeExtraction(skeleton,mask2)

[sizeX, sizeY] = size(skeleton);
%figure; imshow(skeleton,[]);  axis off; title('skeleton'); hold on;
%figure; imshow(mask2,[]);  axis off; title('mask'); hold on;
Im = ~xor(skeleton, mask2);
cleanImg = Im;
%figure; imshow(Im,[]);  axis off; title('Im'); hold on;
% Window
WindowSize = 3;
window = zeros(WindowSize);
border = floor(WindowSize/2);
center = border+1;
row = sizeX + 2*border;
col = sizeY + 2*border;
double temp(row,col);
temp = zeros(row,col);
temp( (center):(end-border), (center):(end-border) ) = Im(:,:);
% Minutiae containers
potentialRidge       = zeros(row,col);
potentialBifurcation = zeros(row,col);
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
            
            potentialRidge(x,y)       = sum(sum(~window));
            potentialBifurcation(x,y) = sum(sum(~window));
            
            % BorderBool is used to find if a certain minutiae is on the
            % border of the mask to ignore them to avoid noisy regions.
            borderBool = isBorder(mask2, x, y);
            if (borderBool == 1)
                potentialRidge(x,y) = -1; 
                potentialBifurcation(x,y) = -1;
            end
        end
    end
end
% Resize area
potentialRidge = potentialRidge(1+border:end-border,1+border:end-border);
potentialBifurcation = potentialBifurcation(1+border:end-border,1+border:end-border);
end