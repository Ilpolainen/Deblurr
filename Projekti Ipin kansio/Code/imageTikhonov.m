function res = imageTikhonov( im, alpha,  starting, threshold, pseudo, constant )
dims = size(im);
n = dims(1);
[red,green,blue] = layers(im);

rm = fromMatToVec(red);
gm = fromMatToVec(green);
bm = fromMatToVec(blue);


r =  conjugateGrad(starting,rm,pseudo,alpha,constant,threshold);


g =  conjugateGrad(starting,gm,pseudo,alpha,constant,threshold);

b =  conjugateGrad(starting,bm,pseudo,alpha,constant,threshold);


r = fromVecToMat(r,n);
b = fromVecToMat(b,n);
g = fromVecToMat(g,n);

res = buildImage(r,g,b,n);

end

