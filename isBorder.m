function bool =  isBorder(mask, x, y)
if (mask(x, y+1) == 0 || mask(x, y-1) == 0 || mask(x+1, y) == 0 || mask(x-1, y) == 0)
    bool = 1;
else 
    bool = 0;
end
end