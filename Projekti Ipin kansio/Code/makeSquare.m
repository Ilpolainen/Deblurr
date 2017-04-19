function res = makeSquare(image,n)
dimensions = size(image);
height = dimensions(1);
width = dimensions(2);
smaller = min(height,width);
sideLength = (smaller-mod(smaller,2^n));
midH = (height-mod(height,2))/2;
midV = (width-mod(width,2))/2;
res = image(midH-sideLength/2+1:midH+sideLength/2,midV-sideLength/2+1:midV+sideLength/2,:); 
end

