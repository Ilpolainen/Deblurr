k=8;
im = imread('fatty.CR2');
im = makeSquare(im,k);

% pieces = divIm(im,k,11);
% 
% 
% corn = zeros(278,278,3);
% 
% corn(:,:,:) = pieces(5,8,:,:,:);
% figure(1);
% imagesc(uint8(corn));


r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);

ratio = 64;
tic
dr = downsample(r,ratio);
dg = downsample(g,ratio);
db = downsample(b,ratio);
toc
'Image downsampled'

newdimensions = size(dr);
n = newdimensions(1);


dsimg = zeros(n,n,3);
dsimg(:,:,1) = dr;
dsimg(:,:,2) = dg;
dsimg(:,:,3) = db;
dsimg = uint8(dsimg);


[disc,psfVec,constant,indexVec] = discPsfVecBuild(3, n);
pseudo = formPseudoMatrix(indexVec,n);

redVec = reshapeToVector(dr);
greenVec = reshapeToVector(dg);
blueVec = reshapeToVector(db);



tic
rblur = applyLightPSF2(redVec,constant,pseudo);
gblur = applyLightPSF2(greenVec,constant,pseudo);
bblur = applyLightPSF2(blueVec,constant,pseudo);
toc
'Image blurred'

alpha = 0;
itercount = 600;
tic
rconstruct = ConjugateGrad(100*eye(n*n,1),rblur,pseudo,alpha,constant,itercount);
'Red recontruction prosessed'
toc
tic
gconstruct = ConjugateGrad(100*eye(n*n,1),gblur,pseudo,alpha,constant,itercount);
'Green recontruction prosessed'
toc
tic
bconstruct = ConjugateGrad(100*eye(n*n,1),bblur,pseudo,alpha,constant,itercount);
'Blue recontruction prosessed'
toc

% % 


blur = buildImage(rblur,gblur,bblur,n);

construct = buildImage(r,g,b,n);

% nois = 50*rand(newheight, newwidth);
% noised = dsimg;
% rnoised = double(noised(:,:,1)) + nois;
% gnoised = double(noised(:,:,2)) + nois;
% bnoised = double(noised(:,:,3)) + nois;
% % % 
% % % 
% noised(:,:,1) = rnoised;
% noised(:,:,2) = gnoised;
% noised(:,:,3) = bnoised;
% 
% noised = uint8(noised);
% 
% haar = imHaar2D(noised,2);
% 
% size(noised)
% 
% [LU,LD,RU,RD]=getLayers(noised,1);
% 
% 
% figure(1);
% clf;
% imagesc(noised);
% title('Noised image');
% 
% figure(2);
% clf;
% imagesc(blur);
% title('Blurred image');
% 
% figure(3);
% clf;
% imagesc(dsimg);
% title('Original image (downsapled)');
% 
% figure(4);
% clf;
% imagesc(haar);
% title('Haar-transform');



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

