function blurred = psfPseudo( f, constant, pseudo )
n = length(f);
blurred = zeros(n,1);

% The function collects summ of values of f indicated in the
% pseudomatrix' indexes, and then multiplies it with the constant value in
% the psf disc.

for iii = 1 : n
    summ = sum(f(pseudo{iii}));
    blurred(iii) = summ * constant;
end

end

