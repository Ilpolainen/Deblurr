function res = imHaar2D( im, n )
    res = myHaarRecursive(double(im),n);
    res = uint8(res);
end

function res = myHaarRecursive(im, n)
if n == 0
    res = im;
    return;
end

dims = size(im);
h = dims(1);
w = dims(2);
[resr,xar,xhr,xvr,xdr] = myHaar(im(:,:,1));
[resg, xag,xhg,xvg,xdg] = myHaar(im(:,:,2));
[resb,xab,xhb,xvb,xdb] = myHaar(im(:,:,3));
res = zeros(h,w,3);

res(:,:,1) = resr;
res(:,:,2) = resg;
res(:,:,3) = resb;

lowPass = res(1:h/2,1:w/2,:);
res(1:h/2,1:w/2,:) = imHaar2D(lowPass,n-1);
end

function [res, a, h, v, d] = myHaar(matrix)
dims = size(matrix);
n = dims(1);
res = zeros(n);


for iii = 1 : n
    res(iii,:) = conv1D(matrix(iii,:));
end
for iii = 1 : n
    temp = transpose(res);
    res(:,iii) = transpose(conv1D(temp(iii,:))); 
end
a = res(1:n/2,1:n/2);
h = res(n/2+1:n,1:n/2);
v = res(1:n/2,n/2+1:n);
d = res(n/2+1:n,n/2+1:n);
end


function res = conv1D(vector)
l = length(vector);
res = zeros(1,l);
details = zeros(1,l/2);
average = details;
f = [1;1];
g = [1;-1];
for iii = 1 : l/2
    first = vector(2*iii-1:2*iii);
    second = vector(2*iii-1:2*iii);
    average(iii) = 1/2 * first*f;
    details(iii) =  1/2 * second*g;
end
res(1:l/2) = average;
res(l/2+1:l) = details;
transpose(res);
end