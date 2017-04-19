function [res,value] = psfIndexpres( size )
% Returns 2D psf disc in form of the index vector presenting the indexes,
% where vectorpresentation of the psf-disc has non-xero value. 
radius = (size-1)/2;
counter = 0;
for iii = -radius : radius
    for jjj = -radius : radius
        if (iii/radius)^2 + (jjj/radius)^2 <= 1
            index = (jjj+radius)*size + iii + radius + 1;
            counter = counter+1
            res(counter) = index;
        end
    end
end
value = 1/counter;
end

