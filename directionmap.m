function [x,y,u,v] = directionmap(DirectionMask, s, I)
   
    [r, c] = size(DirectionMask);
    num = 0.8*s;  % number of lines
             
    % Subsample the directions
    sDir = DirectionMask(s:s:r-s, s:s:c-s);
    xoff = num/2*cos(sDir);
    yoff = num/2*sin(sDir);
    
    % Determine placement of direction vectors
    [x,y] = meshgrid(s:s:c-s, s:s:r-s);
    %figure,mesh(y);
    x = x-xoff;
    y = y-yoff;
    
    % Orientation vectors
    u = xoff*2;
    v = yoff*2;
    
    %quiver(x,y,u,v,0,'.','linewidth',1, 'color','r');
      %axis equal, axis ij,  hold off
end

