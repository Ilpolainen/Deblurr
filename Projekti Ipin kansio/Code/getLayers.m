function [ LU, LD, RU, RD ] = getLayers( im, n )
n
dims = size(im(:,:,1));
w = dims(1);
n = w/2^n;
n
n = uint16(n);
n
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

rLU = r(1:n/2,1:n/2);
gLU = g(1:n/2,1:n/2);
bLU = b(1:n/2,1:n/2);

rLD = r(n/2+1:n,1:n/2);
gLD = g(n/2+1:n,1:n/2);
bLD = b(n/2+1:n,1:n/2);

rRU = r(1:n/2,n/2+1:n);
gRU = g(1:n/2,n/2+1:n);
bRU = b(1:n/2,n/2+1:n);

rRD = r(n/2+1:n,n/2+1:n);
gRD = g(n/2+1:n,n/2+1:n);
bRD = b(n/2+1:n,n/2+1:n);

LU = zeros(n/2,n/2,3);
LD = zeros(n/2,n/2,3);
RU = zeros(n/2,n/2,3);
RD = zeros(n/2,n/2,3);

LU(:,:,1) = rLU;
LU(:,:,2) = gLU;
LU(:,:,3) = bLU;

size(rLD)
size(LD(:,:,1))

LD(:,:,1) = rLD;
LD(:,:,2) = gLD;
LD(:,:,3) = bLD;

RU(:,:,1) = rRU;
RU(:,:,2) = gRU;
RU(:,:,3) = bRU;

RD(:,:,1) = rRD;
RD(:,:,2) = gRD;
RD(:,:,3) = bRD;
end

