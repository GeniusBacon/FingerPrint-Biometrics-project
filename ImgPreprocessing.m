function [EnhancedImg,Direction,freq]=ImgPreprocessing(Img)

%figure,imshow(Img); axis off; title('Original Image'); hold off;

%Adjust Mean,Variance
%Img=rgb2gray(Img);
%NormalizedFP = Normalization(Img,100,10000);       
%figure, imshow(NormalizedFP); axis off; title('Task 1 Normalization'); hold off;


Sharpened = imsharpen(Img,'Radius', 1.5,'Amount',1.2);
%figure; imshow(Sharpened, []); axis off; title('Sharpened'); hold off;



HistFP = histeq(Sharpened);
%figure,imshow(HistFP); axis off; title('Histogram Equalization'); hold off;
%Sharpened = HistFP;                



% Binarizing Image                    
% Threshold=graythresh(Img);
% BinaryImg=imbinarize(Img,Threshold);
% Sharpened = BinaryImg;


% Applying Fast Fourrier Transform to enhance the image:
hsize = 7;
hsigma = 0.2;
h = fspecial('log', hsize, hsigma);
% Ih = imfilter(Is,h);
% Ih = I - Ih;
J = fftshift(fft2(double(Sharpened)));
Jh = imfilter(J,h);
Jh = J - Jh;
Fourierred = abs(ifft2(ifftshift(Jh)));
%figure; imshow(Fourierred, []); axis off; title('After FFT'); hold off;  



% Segmenttion
[SegmentedFP, mask] = ridgesegment(Fourierred,16,0.1);  
%figure,imshow(SegmentedFP); axis off; title('Segmentation'); hold off;   



%Binarizing Image                    
%Threshold=graythresh(Img);
%BinaryImg=imbinarize(Img,Threshold);
%figure,imshow(BinaryImg);



% Calculate the orientation of pixels and the directional map 
[Coherence,Direction]=RidgeOrient(SegmentedFP,7,1,17,3);
DMask  = double(Direction) .*double(mask);
[x,y,u,v] = directionmap(DMask, 7, SegmentedFP);
%figure; imshow(SegmentedFP,[]);  axis off; title('Directions'); hold on;
%quiver(x,y,u,v,0,'.','linewidth',1); hold off;



% Calculate the ridge frequencies map
[freq, medianfreq,waveLength] = ridgefreq(SegmentedFP, mask, Direction, 28, 5 ,3 , 15);
%figure,imshow(freq); axis off; title('Frequency Matrix'); hold off;



% Final Enhancement of th image
EnhancedImg = ridgefilter(SegmentedFP, Direction, freq, 0.5, 0.5);
%figure,imshow(EnhancedImg); axis off; title('Final Image'); hold off;


end