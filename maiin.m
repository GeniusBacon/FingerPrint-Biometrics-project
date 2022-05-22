img1=imread('FilteredDB\8_ (1).jpg');
%img2=imread('FilteredDB\1_ (3).jpg');

%figure; imshow(img1,[]);  axis off; title('original1'); hold on;
 
% Method 1 of matching phase:
% m1 = GetMinutiaeMat(img1);        % Gets every single minutia ( so many )
% m2 = GetMinutiaeMat(img2);    

% m1 = getFinalM(img1, m1);         % Divide img to 25 blocks, takes a single minutiae from each block
% m2 = getFinalM(img2, m2);

%s= match(m1 , m2 , 1);




% Method 2 of matching phase:
authenticate(img1);
 



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
% fclose(file);





