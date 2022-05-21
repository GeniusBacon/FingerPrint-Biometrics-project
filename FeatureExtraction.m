function    [bifurcationX,bifurcationY,bifurcationOrientation,ridgeX,ridgeY,RidgeOrientation]  =FeatureExtraction(EnhancedImg,Direction,freq)
[seg, mask2] = ridgesegment(EnhancedImg,16,0.1); %3ando gabor
Threshold=graythresh(EnhancedImg);
BinaryImg=imbinarize(EnhancedImg,Threshold);
%figure,imshow(BinaryImg);

thinned  = ~bwmorph(~BinaryImg,'thin',Inf); % 'skel'
spured =  bwmorph(thinned,'spur',20);
binarisedMask = BinaryImg.*mask2; %%%%%%eh lazmet el line da
skeleton = spured.*mask2;
%figure; imshow(skeleton,[]); axis off; title('Skeleton'); hold off;

[featureRidge,featureBifurcation]=MinutiaeExtraction(skeleton,mask2);
[ridgeY, ridgeX] = find(featureRidge == 2);
%figure; imshow(skeleton); axis off; title('Ridge endings'); hold on; plot(ridgeX, ridgeY, 'ro'); hold off;
[bifurcationY, bifurcationX] = find(featureBifurcation == 4);
%figure; imshow(skeleton); axis off; title('Bifurcations'); hold on; plot(bifurcationX, bifurcationY, 'bs'); hold off;


orientation = Direction;
sizeB=size(bifurcationX,1);
sizeR=size(ridgeX,1);
bifurcationOrientation=zeros(sizeB,1);
RidgeOrientation=zeros(sizeR,1);

for i=1:sizeB
bifurcationOrientation(i)=orientation(bifurcationY(i),bifurcationX(i));
end

for j=1:sizeR
RidgeOrientation(j)=orientation(ridgeY(j),ridgeX(j));
end 
end