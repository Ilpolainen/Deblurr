function res = ATAmult( xOr, alpha, pseudo, constant )
temp = applyLightPSF2(xOr, constant, pseudo);
temp = applyLightPSF2(temp, constant, pseudo);
res = temp+alpha*xOr;
end

