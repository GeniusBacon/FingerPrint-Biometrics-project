
function Res= Normalization (Img, m0,v0)
Res=im2double(Img);
 DoubleImg=im2double(Img);
 mean=mean2(DoubleImg);
 variance=std2(DoubleImg).^2;
    Res=rgb2gray(Res);
 for i=1:size(DoubleImg,1)
     for j=1:size(DoubleImg,2)
      A=sqrt((((DoubleImg(i,j)-mean).^2).*v0)/variance);
       

         
         if (DoubleImg(i,j)>mean)
            Res(i,j)=m0+A;
         
         else
            Res(i,j)=m0-A;
         end
     end
 end
Res = uint8(Res);
 end
 
 

