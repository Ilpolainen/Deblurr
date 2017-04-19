function res = formPseudoMatrix(index,n)
k = length(index);
center = index((k-1)/2 + 1);
res = cell(1,n*n);
for iii = 1 : n*n
    temp = index+iii-center;
    in = temp > 0;
    temp = temp(in);
    in = temp<=n*n;
    res{1,iii} = temp(in);
end
end