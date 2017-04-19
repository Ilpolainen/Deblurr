function im = buildImage( r,g,b,n )
im = zeros(n,n,3);
r = ReshapeToMatrix(r,n);
g = ReshapeToMatrix(g,n);
b = ReshapeToMatrix(b,n);
im(:,:,1) = r;
im(:,:,2) = g;
im(:,:,3) = b;
im = uint8(im);
end

