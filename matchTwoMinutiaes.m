function bool = matchTwoMinutiaes(m1, m2)

Msize = min( size(m1,1)  , size(m2,1) );
counter = 0;
limit = Msize/10;

for i=1:Msize
    if ( identicalMinutiaes(m1(i,1),m1(i,2), m1(i,3), m1(i,4), m2(i,1), m2(i,2), m2(i,3), m2(i,4) )   )
        counter = counter + 1;
    end 
end


if (counter > limit)
    bool = 1;
else
    bool = 0;
end