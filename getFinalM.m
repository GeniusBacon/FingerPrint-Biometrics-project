function mFinal = getFinalM(pic, M)
length = size(pic, 1);
width = size(pic, 2);
ldividor = length/5;
wdividor = width/5;

mFinal = zeros(5,5);

for i=1:5
    for j=1:5
        regionM = find(M, ( M(1) <= ldividor*i && M(2) <= wdividor*j  ));
        mFinal(i,j) = regionM(1,:);
    end
end

 figure; imshow(pic); axis off; title('pic'); hold on; plot(mFinal(1), mFinal(2), 'bs'); hold off
 
 
 
 
end