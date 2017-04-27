function res = totalVarMult( xOr, alpha, pseudo, constant )
temp = applyLightPSF2(xOr, constant, pseudo);
temp = applyLightPSF2(temp, constant, pseudo);
minus = zeros(length(xOr),1);
minus(2:end,1) = xOr(1:end-1,1);
res = temp+alpha*(xOr-minus);

end

