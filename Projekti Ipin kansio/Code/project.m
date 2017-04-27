% ----------------
% Image reading. Also cutting the image square
% shaped where k is used to cut the image sized 2^k x 2^k. 
% Variable n is important, it's the length of the side of the
% square downsampled image.
% ----------------

im = imread('cat.CR2');
k = 11;
im = makeSquare(im,k);


% ---------------
% Lousy downsampling
% ---------------

red=im(:,:,1);
red = downsample(red,2);
blue=im(:,:,3);
blue = downsample(blue,2);
green=im(:,:,2);
green = downsample(green,2);
dims = size(red);
n = dims(1);

% ------------------
% Putting it back together with helper method. Here n is only needed if the
% layers are in vector-presentation so that the method knows what is the
% size of the image.
% ------------------
im=buildImage(red,green,blue,n);



% --------------------
% Build psf-pseudomatrix which is used in conjugate gradient -algorithm.
% PsfTools also gives the constant of the psf-disc. Indexvec is used to
% form the pseudomatrix containing the indexes of the image that are
% affected by the psf for every point og the convoluted vector. 
% It is used for psfPseudo which does the multiplication with the pseudomatrix. 
% --------------------

[disc,psfVec,constant,indexVec] = psfTools(23,n);
pseudo = formPseudoMatrix(indexVec,n);

% ------------------
% Convert the layers into vectors
% ------------------

rm = fromMatToVec(red);
bm = fromMatToVec(blue);
gm = fromMatToVec(green);


% ----------------
% The iterationcount of the Conjugate Gradient algorithm, and weight alpha.
% starting means x_0. Here it's one dot in the middle.
% ----------------

itercount=100;
alpha=.01;
starting = zeros(n*n,1);
starting(n*n/2,1)=1;

% ----------------
% Performing the algorithm
% ----------------

myR =  ConjugateGrad(starting,rm,pseudo,alpha,constant,itercount);
myB =  ConjugateGrad(starting,bm,pseudo,alpha,constant,itercount);
myG =  ConjugateGrad(starting,gm,pseudo,alpha,constant,itercount);

% -------------------
% Putting it altogether. The matrix conversion might not be needed, but I'm
% not quite sure the buildimage really does what it shpuld, so just in
% case.
% -------------------

myR = fromVecToMat(myR,n);
myB = fromVecToMat(myB,n);
myG = fromVecToMat(myG,n);
myRecon = buildImage(myR,myG,myB,n);

% -----------------------
% Plotting
% -----------------------
figure(1)
imagesc(myRecon);
axis equal
title('My Reconstruction')

figure(3)
imagesc(im);
axis equal
title('Original')


function res = downsample(matrix, k)
si = size(matrix);
h = si(1);
w = si(2);
mh = mod(h,k);
mw = mod(w,k);
nh = (h - mh)/k;
nw = (w - mw)/k;

res = zeros(nh,nw);
for iii = 1 : nh
    for jjj = 1 : nw
        res(iii,jjj)=matrix(iii*k,jjj*k);
    end
end
res = uint8(res);
end

