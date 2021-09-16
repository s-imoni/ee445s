% question 3 code
close all;
fs = 8000;
f0 = 220;
w0 = 2*pi*f0/fs;
n = 0:3*fs;
x = 0.1*cos(w0*n + pi*(0.7*10^(-5)*(n.^2)));
blockSize = 1024;
overlap = 512;
figure;
spectrogram(x, blockSize, overlap, blockSize, fs, 'yaxis');
figure;
spectrogram(x.^2, blockSize, overlap, blockSize, fs, 'yaxis');
figure;
spectrogram(x.^4, blockSize, overlap, blockSize, fs, 'yaxis');
