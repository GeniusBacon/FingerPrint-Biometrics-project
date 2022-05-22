function bool = identicalMinutiaes(x1, y1, t1, a1, x2, y2, t2, a2)
bool = 0;

if (t1 == t2)
    Xtolerance = 250;        % temporary value
    Ytolerance = 250;
    Atolerance = 0.1;
    
    if ( abs(x2-x1) <= abs(Xtolerance) && abs(y2-y1) <= abs(Ytolerance)  && abs(a2-a1) <= abs(Atolerance)  )
        bool = 1;
    end
end

end