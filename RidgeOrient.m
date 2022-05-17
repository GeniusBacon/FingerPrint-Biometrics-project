function [Coherence,Direction]=RidgeOrient(Img,hsize,hsigma,hsize2,hsigma2)

h = fspecial('gaussian', hsize, hsigma);
[hx,hy] = gradient(h);
Gx = filter2(hx, Img);
Gy = filter2(hy, Img);

% Local ridge orientation D (in radiant)
h = fspecial('gaussian', hsize2, hsigma2);

Gxy = Gx.*Gy; Gxy = 2*filter2(h, Gxy);
Gxx = Gx.^2;  Gxx =   filter2(h, Gxx); 
Gyy = Gy.^2;  Gyy =   filter2(h, Gyy);
denom = sqrt((Gxx - Gyy).^2 + Gxy.^2) + eps;
sin2theta =       Gxy./denom;   sin2theta = filter2(h, sin2theta);
cos2theta = (Gxx-Gyy)./denom;   cos2theta = filter2(h, cos2theta);
Direction = pi/2 + atan2(sin2theta,cos2theta)/2;

% Coherence C as reliability of orientation
minima = (Gyy+Gxx)/2 - (Gxx-Gyy).*cos2theta/2 - Gxy.*sin2theta/2;
Imax = Gyy+Gxx - minima;
z = .001;
Coherence = 1 - minima./(Imax+z);
Coherence = Coherence.*(denom>z);
end
 
