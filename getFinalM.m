function mFinal = getFinalM(pic, M)
length = size(pic, 1);
width = size(pic, 2);
ldividor = length/6;
wdividor = width/6;

mFinal = zeros(36,4);
SizeM=size(M,1);
Counter=1;
flag=1;
for i=1:6
    for j=1:6
     
       for k=1:SizeM
          if((M(k,1) <= ldividor*i) && (M(k,1) > ldividor*(i-1)))
             if((M(k,2) <= wdividor*j) && (M(k,2) > wdividor*(j-1)))
                 if(flag==1)
                     
                 if (M(k,3) == 1)
                   mFinal(Counter,:)=M(k,:);
                   Counter=Counter+1;
                   flag=0;
                   break;
                 end
                 else
                   
                   if (M(k,3) == 3)
                   mFinal(Counter,:)=M(k,:);
                   Counter=Counter+1;
                   flag=1;
                   break;
                   end  
                     
                 end
             end
          end
       end
    end
end




 %figure; imshow(pic); axis off; title('pic'); hold on; plot(mFinal(1), mFinal(2), 'bs'); hold off
 
 
 
 
end