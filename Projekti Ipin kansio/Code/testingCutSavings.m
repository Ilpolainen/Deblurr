im = imread('cat.CR2');
k = 11;
im = cut(im,k,2300,1300);


% ---------------
% downsampling
% ---------------
dsr = 2;
im = imresize(im,0.5^(dsr-1));

piece = im;
dims = size(piece);
n = dims(1);

radius = 11;

% pieces = divIm(im,6,2*radius+1);
% dims2 = size(pieces);
% arrayW = dims2(1);
% pieceW = dims2(3);
% 
% 
% [disc,psfVec,constant,indexVec] = psfTools(radius,pieceW);
% pseudo = formPseudoMatrix(indexVec,pieceW);
% 
alpha=.001;
% threshold = 0.0001;
% starting = zeros(pieceW*pieceW,1);
% starting(pieceW*pieceW/2,1)=1;

% tic
% for iii = 1:arrayW
%     for jjj = 1:arrayW
%         piece=zeros(pieceW,pieceW,3);
%         piece(:,:,:) = pieces(iii,jjj,:,:,:);
%         constr = imageTikhonov( piece, alpha, starting, threshold, pseudo, constant );
%         pieces(iii,jjj,:,:,:) =  constr; 
%     end
% end
% toc
% disp('Divided image reconstruction time.')

[disc,psfVec,constant,indexVec] = psfTools(radius,n);
pseudo = formPseudoMatrix(indexVec,n);

starting = zeros(n*n,1);
starting(n*n/2,1)=1;
threshold = 0.0000001;

tic
rec = imageTikhonov( im, alpha, starting, threshold, pseudo, constant);
toc
disp('Whole image reconstruction time.')
