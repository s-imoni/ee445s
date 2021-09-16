% QUESTION 2:
% part a, generate chirp signal
clear all; close all; clc; 
fs = 44100; 
f0 = 20;
fstep = 420;
Ts = 1/fs;
N = ceil(10/(88*Ts));
t = Ts : Ts : N*Ts;
key = 1:1:88;
vec = zeros(1, length(key)*N);
for i = 1:length(key)
    note = cos(2*pi*(f0+t.*0.5*key(i)*fstep).*t);
    vec((i-1)*N+1 : i*N) = note;
end
vec = (vec - mean(vec));
%part b, plotspec
figure;
plotspec(vec, Ts);

%part c, play the signal
soundsc(vec, fs); % soundsc

%part d, spectogram + stem
figure;
blockSize = 256;
shift = 128;
overlap = blockSize - shift;
spectrogram(vec, hamming(blockSize), overlap, blockSize, fs, 'yaxis');

figure;
stem(hamming(256));

