% ----------------
% Image reading. Also cutting the image square
% shaped where k is used to cut the image sized 2^k x 2^k. 
% Variable n is important, it's the length of the side of the
% square downsampled image.
% ----------------

im = imread('cat.CR2');
k = 11;
im = cut(im,k,2300,1300);

imagesc(im);
% ---------------
% downsampling
% ---------------
dsr = 2;
im = imresize(im,0.5^(dsr-1));

piece = im;
dims = size(piece);
n = dims(1);


% ------------------
% Convert the layers into vectors
% ------------------

[red,green,blue] = layers(piece);
rm = fromMatToVec(red);
gm = fromMatToVec(green);
bm = fromMatToVec(blue);


% --------------------
% Build psf-pseudomatrix which is used in conjugate gradient -algorithm.
% PsfTools also gives the constant of the psf-disc. Indexvec is used to
% form the pseudomatrix containing the indexes of the image that are
% affected by the psf for every point og the convoluted vector. 
% It is used for psfPseudo which does the multiplication with the pseudomatrix. 
% --------------------

radius = 11;
[disc,psfVec,constant,indexVec] = psfTools(radius,n);
pseudo = formPseudoMatrix(indexVec,n);



% ----------------
% The iterationcount of the Conjugate Gradient algorithm, and weight alpha.
% starting means x_0. Here it's one dot in the middle.
% ----------------

alpha=.01;
threshold = 0.0000001;
starting = zeros(n*n,1);
starting(n*n/2,1)=1;


% ----------------
% Performing the algorithm
% ----------------

tic
myR =  conjugateGrad(starting,rm,pseudo,alpha,constant,threshold);
'Red Processed'
toc
tic
myG =  conjugateGrad(starting,gm,pseudo,alpha,constant,threshold);
'Green Processed'
toc
tic
myB =  conjugateGrad(starting,bm,pseudo,alpha,constant,threshold);
'Blue Processed'
toc
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
clf
imagesc(myRecon);
axis equal
title('My Reconstruction')


figure(2)
clf
imagesc(im);
axis equal
title('Original')

