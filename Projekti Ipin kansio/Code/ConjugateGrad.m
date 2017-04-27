function res = conjugateGrad( x, m, pseudo, alpha, constant, itercount )
b = applyLightPSF2(m, constant, pseudo);
r = b - ATAmult(x,alpha,pseudo,constant);
threshold = .00000001;
for iii = 1 : itercount
    Ar = ATAminusAlphaMult(r, alpha, pseudo, constant);
    t = 1/(transpose(r)*Ar) * (transpose(r)*r);
    temp = x;
    x = temp + t * r;
%     if norm(temp - x) < threshold
%         'stopped'
%         iii
%         break
%     end
    if mod(iii,10) == 1
     r = b-ATAminusAlphaMult(x,alpha,pseudo,constant);
    else
       r = r - t*Ar;
    end
    
end
res = x;

end

