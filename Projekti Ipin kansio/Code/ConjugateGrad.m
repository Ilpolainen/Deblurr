function res = conjugateGrad( x, m, pseudo, alpha, constant, threshold )
% Performs the conjugate gradient algorithm, x is the x_0 which could
% basically be any vector, but will converge faster if it's just one spot
% in the middle. m is our measurement (blurry picture) which has to be
% multiplied with A^T (here the same as A) because our formula is in form
% of (A^TA-alpha*I)f = A^tm. Itercount should be replaced with somekind of
% stopping system. alpha is the weight of the algorithm and constant and
% pseudo are together the representation of the psf-matrix.
%
% the needed multiplication of measurement
b = psfPseudo(m, constant, pseudo);

% the first residual of the algorithm. Residual is our gradient times -1.
r = b - ATAminusAlphaMult(x,alpha,pseudo,constant);


for iii = 1 : 100
    % Ar is stored in order to avoid one matrix multiplication.
    Ar = ATAminusAlphaMult(r, alpha, pseudo, constant);
    
    % The amount how much it is to be moved to the correct direction along
    % the function slope.
    t = 1/(transpose(r)*Ar) * (transpose(r)*r);
    
    % For ending the loop we want to see the difference between
    % iterations.
    temp = x;
    % The actual "movement".
    x = x + t * r;
    
    if (norm(temp - x)/length(x))^2 < threshold 
        disp('Converged within :');
        disp(iii)
        disp('iterations.')
        break
    end
    % ----------------
    % two ways to count the next residual. Every now and then the more accurate
    % way is needed. Theoretically however, they are the same.
    % ----------------
    if mod(iii,10) == 1
        
        r = b-ATAminusAlphaMult(x,alpha,pseudo,constant);
    else
       r = r - t*Ar;
    end
    if (iii == 100)
        disp('Iteration stopped because of too slow convergence.');
    end
end
res = x;

end

