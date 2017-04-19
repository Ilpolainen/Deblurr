function res = conv2D( image,kernel )
k = length(kernel);
center = (k - 1) / 2;
image = double(image);
imdim = size(image);
h = imdim(1);
w = imdim(2);
res = zeros(h,w);

for iii = 1 : h
    for jjj = 1 : w
        for mmm = -center : center
            for nnn = -center : center
                iindex = iii-nnn;                
                jindex = jjj-mmm;
                value = 0;
                if (iindex > 0 && iindex <= h && jindex > 0 && jindex <= w)
                    value = image(iindex,jindex)*kernel(mmm+center+1,nnn+center+1);
                end
                res(iii,jjj) = res(iii,jjj)+value;
            end
        end
    end
end

end

