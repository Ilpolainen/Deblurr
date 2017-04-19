im = imread('clock.jpg');
im = makeSquare(im,8);
pieces = divIm(im,4,3);
imagesc(im);