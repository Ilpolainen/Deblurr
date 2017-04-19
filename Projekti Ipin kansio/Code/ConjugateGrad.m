function res = ConjugateGrad( x, m, pseudo, alpha, constant, itercount )
b = applyLightPSF2(m, constant, pseudo);
r = b - ATAmult(x,alpha,pseudo,constant);
for iii = 1 : itercount
    Ar = ATAmult(r, alpha, pseudo, constant);
    t = (transpose(r)*r)./(transpose(r)*Ar);
    x = x + t * r;
    r = b-ATAmult(x,alpha,pseudo,constant);
%     r = r - t*Ar;
    
end
res = x;

end

