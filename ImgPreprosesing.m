Img=imread('DB\12_2.jpg');
%Input image
%figure,imshow(Img); axis off; title('Original Image'); hold off;

%Adjust Mean,Variance
%Img=rgb2gray(Img);
%NormalizedFP = Normalization(Img,100,10000);
%figure, imshow(NormalizedFP); axis off; title('Task 1 Normalization'); hold off;

Sharpened = imsharpen(Img,'Radius', 1.5,'Amount',1.2); %
figure; imshow(Sharpened, []); axis off; title('Sharpened'); hold off;

HistFP = histeq(Sharpened);        % not used yet
%figure,imshow(HistFP); axis off; title('Histogram Equalization'); hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hsize = 7;
hsigma = 0.2;
h = fspecial('log', hsize, hsigma);
% Ih = imfilter(Is,h);
% Ih = I - Ih;
J = fftshift(fft2(double(Sharpened)));
Jh = imfilter(J,h);
Jh = J - Jh;
Fourierred = abs(ifft2(ifftshift(Jh)));

figure; imshow(Fourierred, []); axis off; title('After FFT'); hold off;     % should be affecting the frequency

%SegmentedFP = Fourierred;
[SegmentedFP, mask] = ridgesegment(Fourierred,16,0.1); %3ando gabor
figure,imshow(SegmentedFP); axis off; title('Segmentation'); hold off;% seems to be just like the after fft

%Binarizing Image                    : Try it before the Fourrier 
 %Threshold=graythresh(Img);
 %BinaryImg=imbinarize(Img,Threshold);
 %figure,imshow(BinaryImg);
 
[Coherence,Direction]=RidgeOrient(SegmentedFP,7,1,17,3);
DMask  = double(Direction) .*double(mask);
[x,y,u,v] = directionmap(DMask, 7, SegmentedFP);
CMask = double(Coherence).*double(mask);
figure; imshow(SegmentedFP,[]);  axis off; title('Directions'); hold on;
quiver(x,y,u,v,0,'.','linewidth',1); hold off;

[freq, medianfreq,waveLength] = ridgefreq(SegmentedFP, mask, Direction, 28, 5 ,3 , 15);
figure,imshow(freq); axis off; title('Frequency Matrix'); hold off;

newim = ridgefilter(SegmentedFP, Direction, freq, 0.5, 0.5);

figure,imshow(newim); axis off; title('Final Image'); hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%














%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Feature Extraction

[seg, mask2] = ridgesegment(newim,16,0.1); %3ando gabor

Threshold=graythresh(newim);
 BinaryImg=imbinarize(newim,Threshold);
 %figure,imshow(BinaryImg);

 
thinned  = ~bwmorph(~BinaryImg,'thin',Inf); % 'skel'
skeleton =  bwmorph(thinned,'spur',20);
binarisedMask = BinaryImg.*mask2;
skeletonMask = skeleton.*mask2;

%figure; imshow(skeletonMask,[]); axis off; title('Skeleton'); hold off;

[Gx2, Gy2, D2, C2] = ridgeorientation(newim, 1, 17, 3);
C2Mask = double(C2).*double(mask2);
minima = ~imregionalmin(C2Mask);
candidateFeatures = double(~minima).*double(mask2);
[minimaY, minimaX] = find(candidateFeatures == 1);
%figure; imshow(C2Mask, []); axis off; title('Coherence 2');
%figure; imshow(minima, []); axis off; title('Minima'); hold on; plot(minimaX, minimaY, 'og', 'MarkerSize',10); hold off;

candidateRegion = ~imbinarize(C2Mask,0.5).*double(mask2);
%figure; imshow(candidateRegion,[]); axis off; title('Candidate Region');
