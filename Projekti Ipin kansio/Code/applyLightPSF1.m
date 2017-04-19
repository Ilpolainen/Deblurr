function blurred = applyLightPSF1( f, index, constant )
n = length(f);
center = index((length(index)-1)/2 + 1);
blurred = zeros(n,1);

for iii = 1 : n
    temp = index+iii-center;
    in = temp > 0;
    temp = temp(in);
    in = temp<=n;
    temp = temp(in);
    summ = sum(f(temp(in)));
    blurred(iii) = summ * constant;
end


end

