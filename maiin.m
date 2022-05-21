img1=imread('DB\7_1.jpg');
img2=imread('DB\3_5.jpg');

%figure; imshow(img1,[]);  axis off; title('original1'); hold on;

 m1 = GetMinutiaeMat(img1);
 m2 = GetMinutiaeMat(img2);
 
 m1 = getFinalM(img1, m1);
 m2 = getFinalM(img2, m2);

 


 

s= match(m1 , m2 , 1);
