img1=imread('FilteredDB\10_ (1).jpg');
img2=imread('FilteredDB\10_ (3).jpg');

%figure; imshow(img1,[]);  axis off; title('original1'); hold on;

 m1 = GetMinutiaeMat(img1);
 m2 = GetMinutiaeMat(img2);
 
 %m1 = getFinalM(img1, m1);
 %3m2 = getFinalM(img2, m2);
 
 
 
s= match(m1 , m2 , 1);


% file = fopen('DB_Path.txt', 'rt');
% fingerprint = fgetl(file);
% Lines = 1;



% while ischar(fingerprint)
%     FingerPrintImg=imread(fingerprint);
%     Minutiaes=GetMinutiaeMat(FingerPrintImg);
%     
% 	fingerprint = fgetl(file);
%     display(fingerprint);
%         if isempty(fingerprint)
%             break;
%         end
% 	Lines = Lines + 1;
% end
% All done reading all lines, so close the file.
% fclose(file);
%Here we plot the ROC curve
x_0 = randn(1,100);
x_1 = randn(1,604) + 2;

% Compute and plot the ROC curve
h = computeROC(x_0, x_1);





