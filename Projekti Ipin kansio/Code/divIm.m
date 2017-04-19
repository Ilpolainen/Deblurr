function [ pieceArray ] = divIm( im, k, psfW )
% ------
% NO VALIDATION
% ------
dims = size(im);
imagewidth = dims(1);
piecewidth = 2^k;

totalMarginal = psfW*2;

piecesPerSide = imagewidth/piecewidth;
pieceArray = zeros(piecesPerSide,piecesPerSide,piecewidth+totalMarginal,piecewidth+totalMarginal,3);
pieceArray(:,:,:,:,1) = divLayer(im(:,:,1), piecewidth, psfW);
pieceArray(:,:,:,:,2) = divLayer(im(:,:,2), piecewidth, psfW);
pieceArray(:,:,:,:,3) =  divLayer(im(:,:,3), piecewidth, psfW);

end

function [ pieceArray ] = divLayer( layer, pieceWidth, psfW )
totalMarginal = psfW*2; 
dims = size(layer);
pieces = dims(1)/pieceWidth;

pieceArray = zeros(pieces,pieces,pieceWidth+totalMarginal,pieceWidth+totalMarginal);
pieceArray = fillPieceArray( layer, psfW, pieceArray, pieceWidth);

end

function [pieceArray] = fillPieceArray( layer, psfW, pieceArray, pieceWidth)
    piecesPerSide = length(pieceArray(:,1,1,1));
    for iii = 2 : piecesPerSide - 1
        for jjj = 2: piecesPerSide - 1
            pieceArray(iii,jjj,:,:) = layer((iii-1)*pieceWidth+1-psfW:iii*pieceWidth+psfW,(jjj-1)*pieceWidth+1-psfW:jjj*pieceWidth+psfW);
        end
    end
    
    pieceArray(1,1, end/2+1:end,end/2+1:end) = layer(1:pieceWidth/2+psfW,1:pieceWidth/2+psfW);
    pieceArray(end,end, 1:end/2, 1:end/2) = layer(end-psfW-pieceWidth/2+1 : end,end-psfW-pieceWidth/2+1 : end);
    pieceArray(1,end,end/2+1:end,1:end/2) = layer(1:pieceWidth/2+psfW,end-psfW-pieceWidth/2+1 : end);
    pieceArray(end,1,1:end/2, end/2+1:end) = layer(end-psfW-pieceWidth/2+1 : end,1:pieceWidth/2+psfW);
    
    for iii = 2 : piecesPerSide - 1
        pieceArray(1,iii, end/2+1:end,:) = layer(1:pieceWidth/2+psfW,(iii-1)*pieceWidth+1-psfW:iii*pieceWidth+psfW);
        pieceArray(end,iii, 1:end/2,:) =  layer(end-psfW-pieceWidth/2+1:end,(iii-1)*pieceWidth+1-psfW:iii*pieceWidth+psfW);
        pieceArray(iii,1,:,end/2+1:end) =  layer((iii-1)*pieceWidth+1-psfW:iii*pieceWidth+psfW,1:pieceWidth/2+psfW);
        pieceArray(iii,end,:,1:end/2) =  layer((iii-1)*pieceWidth+1-psfW:iii*pieceWidth+psfW,end-psfW-pieceWidth/2+1:end);
    end
end