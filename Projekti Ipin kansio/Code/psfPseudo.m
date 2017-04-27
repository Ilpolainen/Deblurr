function blurred = psfPseudo( f, constant, pseudo )
n = length(f);
blurred = zeros(n,1);

for iii = 1 : n
    summ = sum(f(pseudo{iii}));
    blurred(iii) = summ * constant;
end

end

