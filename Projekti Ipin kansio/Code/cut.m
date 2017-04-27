function res = cut( im, x,y,side )
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

empty = zeros(side,side,3);
empty(:,:,1) = r(y:y+side,x:x+side);
empty(:,:,2) = g(y:y+side,x:x+side);
empty(:,:,3) = b(y:y+side,x:x+side);

res = empty;
end

