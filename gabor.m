
unifreq=unique(waveLength);
sizfreq=size(unifreq,1);
Wavelengths=reshape(unifreq,[1,sizfreq]);
Wavelengths(Wavelengths<2) = [];


%Uniorint=unique(Direction);
sizorint=size(Direction);
sizorint=sizorint(1)*sizorint(2);
%orientation=reshape(Uniorint,[1,sizorint]);
orientation = rad2deg(Direction);
%orientation(orientation<2) = [];

%orientation = [0 45 90 135];

Oorientation = [0 15 30 45 60 75 90 105 115 135 155 175];


orientation=reshape(orientation,[1,sizorint]);

f=gabor(Wavelengths,Oorientation);

mag= imgaborfilt(SegmentedFP,f);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[height, width, num_filters] = size(mag(:,:,:));
combined_mag = zeros(height,width);

% Average the values from each filter
for i = 1:height
    for j = 1:width
        sum = 0;
        for f = 1:num_filters
            sum = sum + mag(i,j,f);
        end
        combined_mag(i,j) = sum / num_filters;
    end
end
%imshow(combined_mag,[]);title('combined mag'); hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
 NormalizedFP = Normalization(combined_mag,100,10000);
 imshow(NormalizedFP,[]);title('Gabor normalize'); hold off;
 Is = imsharpen(NormalizedFP,'radius' , 1.5, 'Amount' , 1.2);
 imshow(Is,[]);title('Gabor sharp'); hold off;
 HistFP = histeq(Is);
 imshow(HistFP,[]);title('Gabor hist'); hold off;
 [SegmentedFP, mask] = ridgesegment(HistFP,16,0.1);
 
  NormalizedFP = Normalization(SegmentedFP,100,10000);
 imshow(NormalizedFP,[]);title('Gabor normalize2'); hold off;
 Is = imsharpen(NormalizedFP,'radius' , 1.5, 'Amount' , 1.2);
 imshow(Is,[]);title('Gabor sharp2'); hold off;
 HistFP = histeq(Is);
 imshow(HistFP,[]);title('Gabor hist2'); hold off;
 [SegmentedFP, mask] = ridgesegment(HistFP,16,0.1);
 imshow(SegmentedFP,[]);title('Gabor seg2'); hold off;
 %BinaryImg=imbinarize(SegmentedFP,Threshold);
 %imshow(BinaryImg,[]);

%for i=1:312
%figure; imshow(mag(:,:,i),[]);  axis off; title('Gabor Magnitude'); hold on;
%figure; imshow(phase(:,:,i),[]);  axis off; title('Gabor Phase'); hold on;
%end
