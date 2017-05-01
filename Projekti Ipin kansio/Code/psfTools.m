function [disc,psfVec,constant,indexVec] = psfTools( r, n )
% The function returns the matrixpresentation of the convolution disc, the
% 2D-psf in form of vector, the constant value of the disc 
% (same value than the non-zero value in the disc and the psfVec). The
% index-vec gives just the indexes of the non-zero-value in the psfVector.
size = 2*r+1;
psf = zeros(size,size);
counter = 0;


for iii = -r : r
    for jjj = -r : r
        if ((iii/r)^2 + (jjj/r)^2 <= 1)
            counter = counter +1;
            psf(iii+r+1,jjj+r+1) = 1;
        end
    end
end

constant = 1/counter;
psf = constant * psf;

psfVec = zeros(1,n*n);
for iii = 1 : size
    psfVec(1,(iii-1)*n+1:(iii-1)*n+size) = psf(iii,:);
end
disc = psf;
indexVec = find(psfVec>0);
end