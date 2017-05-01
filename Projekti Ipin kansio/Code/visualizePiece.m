function res = visualizePiece(pieces,iii,jjj)
dims = size(pieces);
width = dims(3);
piece = zeros(width,width,3);
piece(:,:,:) = pieces(iii,jjj,:,:,:);
piece = uint8(piece);
res = piece;
figure((iii-1)*dims(1)+jjj);
clf
imagesc(piece);
axis equal
end

