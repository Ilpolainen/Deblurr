function res = cut(image,k,x,y)
% Given image, the method returns subimage from (x,y) to (x+2^k-1,y+2^k-1).
% Insures the new image is square and the length of the side is power of
% two.
res = zeros(2^k,2^k,3);
res(:,:,:)=image(y:y+2^k-1,x:x+2^k-1,:);
res = uint8(res);
end

