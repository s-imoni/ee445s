[h,f] = freqz(Num, Den, 24, 48000);
dB = 20*log10(abs(h));
disp(dB')
figure; plot(dB);
