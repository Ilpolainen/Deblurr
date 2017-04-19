function res = ReshapeToMatrix( vector, n )
res = zeros(n,n);
for iii = 1 : n
    res(:,iii) = vector((iii-1)*n+1:iii*n);
end

end

