function res = fullPsf( pseudo, constant, n )
res = zeros(n*n,n*n);
for iii = 1 : n * n
    vec = pseudo{iii};
    res(iii,vec) = constant; 
end
end

