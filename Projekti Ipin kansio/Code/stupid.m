rf = fft2(rnoised);
gf = fft2(gnoised);
bf = fft2(bnoised);
dimis = size(rf);
hh = dimis(1);
ww = dimis(2);
for iii = 1 : hh
    for jjj = 1 : ww    
       rf(iii,jjj)=sqrt(real(rf(iii,jjj)^2<0.01) + imag(rf(iii,jjj))^2);
       gf(iii,jjj)=sqrt(real(gf(iii,jjj)^2<0.01) + imag(gf(iii,jjj))^2);
       bf(iii,jjj)=sqrt(real(bf(iii,jjj)^2<0.01) + imag(bf(iii,jjj))^2);
    end
end
rr = ifft2(rf);
gg = ifft2(gf);
bb = ifft2(bf);

rr = uint8(rr);
gg = uint8(gg);
bb = uint8(bb);

darken = 2;

pic = uint8(zeros(hh,ww,3));
pic(:,:,1) = uint8(rf)/darken;
pic(:,:,2) = uint8(gf)/darken;
pic(:,:,3) = uint8(bf)/darken;

figure(5)
imagesc(pic);
