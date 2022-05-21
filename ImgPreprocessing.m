function [EnhancedImg,Direction,freq]=ImgPreprocessing(Img)
%Input image
%figure,imshow(Img); axis off; title('Original Image'); hold off;

%Adjust Mean,Variance
%Img=rgb2gray(Img);
%NormalizedFP = Normalization(Img,100,10000);           % seems to just turn the background greyer: TEST ACCURACY
%figure, imshow(NormalizedFP); axis off; title('Task 1 Normalization'); hold off;

Sharpened = imsharpen(Img,'Radius', 1.5,'Amount',1.2);
%figure; imshow(Sharpened, []); axis off; title('Sharpened'); hold off;

HistFP = histeq(Sharpened);        % not used yet
%figure,imshow(HistFP); axis off; title('Histogram Equalization'); hold off;
%Sharpened = HistFP;                % testing to use the histFP, but seems to cause worse results.: TEST ACCURACY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Binarizing Image                    % Try it before the Fourrier TESTINGGG: TEST ACCURACY
% Threshold=graythresh(Img);
% BinaryImg=imbinarize(Img,Threshold);
% Sharpened = BinaryImg;

hsize = 7;
hsigma = 0.2;
h = fspecial('log', hsize, hsigma);
% Ih = imfilter(Is,h);
% Ih = I - Ih;
J = fftshift(fft2(double(Sharpened)));
Jh = imfilter(J,h);
Jh = J - Jh;
Fourierred = abs(ifft2(ifftshift(Jh)));
%figure; imshow(Fourierred, []); axis off; title('After FFT'); hold off;     % should be affecting the frequency

[SegmentedFP, mask] = ridgesegment(Fourierred,16,0.1); %3ando gabor
%figure,imshow(SegmentedFP); axis off; title('Segmentation'); hold off;      % seems to be just like the after fft
%SegmentedFP = Fourierred;   %               TESTING: TEST ACCURACY

%Binarizing Image                    : Try it before the Fourrier : TEST ACCURACY
 %Threshold=graythresh(Img);
 %BinaryImg=imbinarize(Img,Threshold);
 %figure,imshow(BinaryImg);
 
[Coherence,Direction]=RidgeOrient(SegmentedFP,7,1,17,3);
DMask  = double(Direction) .*double(mask);
[x,y,u,v] = directionmap(DMask, 7, SegmentedFP);
CMask = double(Coherence).*double(mask);
%figure; imshow(SegmentedFP,[]);  axis off; title('Directions'); hold on;
%quiver(x,y,u,v,0,'.','linewidth',1); hold off;

[freq, medianfreq,waveLength] = ridgefreq(SegmentedFP, mask, Direction, 28, 5 ,3 , 15);
%figure,imshow(freq); axis off; title('Frequency Matrix'); hold off;

EnhancedImg = ridgefilter(SegmentedFP, Direction, freq, 0.5, 0.5);
%figure,imshow(EnhancedImg); axis off; title('Final Image'); hold off;


end