function [disc,psfVec,constant,indexVec] = psfTools( size, n )

radius = (size-1)/2;

psf = zeros(size,size);
counter = 0;


for iii = -radius : radius
    for jjj = -radius : radius
        if ((iii/radius)^2 + (jjj/radius)^2 <= 1)
            counter = counter +1;
            psf(iii+radius+1,jjj+radius+1) = 1;
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