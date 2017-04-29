function im = buildImage( r,g,b,n )
im = zeros(n,n,3);
r = fromVecToMat(r,n);
g = fromVecToMat(g,n);
b = fromVecToMat(b,n);
im(:,:,1) = r;
im(:,:,2) = g;
im(:,:,3) = b;
im = uint8(im);
end

