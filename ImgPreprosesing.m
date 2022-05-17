Img=imread('DB\1_4.jpg');
%Input image
figure,imshow(Img);
%%%%%%%%%%%%%%%%%%%%%%%%%
%Adjust Mean,Variance
NormalizedFP = Normalization(Img,100,10000);
figure,imshow(NormalizedFP);

 Img=rgb2gray(Img);
 HistFP = histeq(Img);
 figure,imshow(HistFP);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SegmentedFP = fingerprint_segmentation(NormalizedFP);

%%%%%%%%%%%%%%%%%%%%%%%%%%
%Binarizing Image
 Threshold=graythresh(Img);
 BinaryImg=imbinarize(Img,Threshold);
 figure,imshow(BinaryImg);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Coherence,Direction]=RidgeOrient(BinaryImg,7,1,17,3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DMask  = double(Direction) .*double(BinaryImg);
[x,y,u,v] = directionmap(DMask, 6, BinaryImg);
CMask = double(Coherence).*double(BinaryImg);
figure; imshow(BinaryImg,[]);  axis off; title('Directions'); hold on; quiver(x,y,u,v,0,'.','linewidth',1); hold off;
