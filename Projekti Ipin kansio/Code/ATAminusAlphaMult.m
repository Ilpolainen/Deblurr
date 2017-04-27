function res = ATAminusAlphaMult( x, alpha, pseudo, constant )
% Performs the matrix multiplication (A^TA+alphaI)x
% Naturally needs alpha and x. A comes in form of index matrix and the
% psf constant that psfPseudo needs in order to perform one multiplication.
temp = psfPseudo(x, constant, pseudo);
temp = psfPseudo(temp, constant, pseudo);
res = temp+alpha*x;
end

