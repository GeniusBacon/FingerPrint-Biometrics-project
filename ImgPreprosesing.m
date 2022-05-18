Img=imread('DB\1_1.jpg');
%Input image
%figure,imshow(Img);
%%%%%%%%%%%%%%%%%%%%%%%%%
%Adjust Mean,Variance
%Img=rgb2gray(Img);
%NormalizedFP = Normalization(Img,100,10000);
%figure, imshow(NormalizedFP);
Img=rgb2gray(Img);
HistFP = histeq(Img);
%figure,imshow(HistFP);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[SegmentedFP, mask] = ridgesegment(Img,16,0.1);
%figure, imshow(Img);
%figure,imshow(SegmentedFP);
%figure,imshow(mask);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%Binarizing Image
 Threshold=graythresh(Img);
 BinaryImg=imbinarize(Img,Threshold);
 %figure,imshow(BinaryImg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Coherence,Direction]=RidgeOrient(SegmentedFP,7,1,17,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DMask  = double(Direction) .*double(mask);
[x,y,u,v] = directionmap(DMask, 7, SegmentedFP);
CMask = double(Coherence).*double(mask);
figure; imshow(SegmentedFP,[]);  axis off; title('Directions'); hold on;
quiver(x,y,u,v,0,'.','linewidth',1); hold off;
%figure, imshow(DMask);
%figure, imshow(CMask);


[freq, medianfreq] = ridgefreq(SegmentedFP, mask, Direction, 24, 5 ,5 , 15);
figure,imshow(freq);
