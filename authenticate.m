function authenticate(input_img)


inputM = GetMinutiaeMat(input_img);
score = zeros(38);


for i=1:10
    
   for j=1:6
      name = strcat('FilteredDB\', num2str(i), '_ (', num2str(j), ').jpg');
      img = imread(name);
      
      if (img == input_img)
         continue;
      end
      M2 = GetMinutiaeMat(img);
      matching = matchTwoMinutiaes(inputM, M2);
      if (matching == 1)
         score(i) = score(i) +1;
      end
   end
   disp(i);
   disp(score(i));
end


maxi = -1;
personIndex = -1;
for i=1:38
    if (score(i) > maxi && score(i)~=6)
        maxi = score(i);
        personIndex = i;
    end
end

if (maxi>=2)       
    ! It matched with person: 
    disp(personIndex);
else
    ! No match found
end


















end