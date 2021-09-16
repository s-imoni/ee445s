% QUESTION 2:
% part a, generate chirp signal
clear all; close all; clc; 
fs = 44100; 
f0 = 20;
fstep = 420;
Ts = 1/fs;
Tmax = 10;
t = Ts : Ts : Tmax;
vec = cos(2*pi*(f0+t.*0.5*fstep).*t);
vec = (vec - mean(vec));
%part b, plotspec
figure;
plotspec(vec, Ts);

%part c, play the signal
%soundsc(vec, fs); % soundsc: 
% sounds like an emergency siren, but only the first half
% sweeping sound that starts at a low frequency and works its way up

%part d, spectogram + stem
figure;
blockSize = 256;
shift = 128;
overlap = blockSize - shift;
spectrogram(vec, hamming(blockSize), overlap, blockSize, fs, 'yaxis');

figure;
stem(hamming(256));

