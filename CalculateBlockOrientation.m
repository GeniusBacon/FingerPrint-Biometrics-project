function orientation = CalculateBlockOrientation(block_struct)
 x = block_struct.data;
 [GMag,GDir] = gradient(x);
 sze=size(x,1);
 
 SqMag=power(GMag,2);
 twoTheta=2.*GDir;
 multip=1/(power(sze,2));
 
 Dy=multip*sum(SqMag.*cos(twoTheta));
 Dx=multip*sum(SqMag.*sin(twoTheta));
 
 
 orientation=atan((Dy/Dx));
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
[~,Gdir] = imgradient(x');
Gdir = Gdir - 90;
%Gdir is an angle perpendicular to the correct angle direction

 
unique_angles = unique(sort(Gdir(:)));
x_angles = unique_angles;

x_angles=360+x_angles((x_angles<0));
end

x_size = size(x_angles,1);
y_count = zeros(1, x_size);
for i = 1: x_size
    y_count(i, 1) = size(find(Gdir == x_angles(i,1)),1);
end
figure,imshow(x);
figure, plot(x_angles(:,1), y_count(:,1))
orientation=0;
end