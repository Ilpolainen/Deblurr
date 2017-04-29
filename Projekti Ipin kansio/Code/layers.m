function [ r,g,b ] = layers( im )
% Returns the layers of rgb image.
sz = size(im);
w = sz(1);
h = sz(2);
r = zeros(w,h);
g = r;
b = r;

r(:,:) = im(:,:,1);
g(:,:) = im(:,:,2);
b(:,:) = im(:,:,3);

end

