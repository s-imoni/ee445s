close all; clear all; clc;
f0 = 100;
Ts = 0.001;
fs = 1/Ts;
% time vector
t = 0:Ts:.999;

%sinusoidal
xt = sin(2*pi*f0*t);
n = length(t);

%plotting
figure;
plot(t, xt);

%label
xlabel("x");
ylabel("xt");
title("x vs xt");

%finding values
disp('At .32 sec')
t(321)
xt(321) % at .32 sec

disp('At .64 sec')
t(641)
xt(641) % at .64 sec

% sampling
xn = xt(1:8:end);
% plot
hold on;
stem(t(1:8:end), xn);

%fourier
yt = fftshift(fft(xt));
% convert to dB
f = 10*log10(abs(yt));
%plot range
range = (-fs/2):(fs/n):(fs/2 - fs/n);
figure;
plot(range, f);

%freqz
figure;
freqz(xt);

%stopwatch timer
tic
A = rand(5000);
B = rand(5000);
C = A*B;
toc

%profiler
profile on -timer 'cpu' 
myfunction();
profile off
profile viewer

A = rand(5000);
B = rand(5000);
% bytes = 200000000

disp('whos result:')
whos
disp('whos for A')
var_info = whos('A')
disp('A bytes/(10^6)')
var_info.bytes/1000000
% MB = 200

%function
function C = myfunction()
    A = rand(5000);
    B = rand(5000);
    C = A*B;
end










