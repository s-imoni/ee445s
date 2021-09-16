close all;
%%% Generate chirp signal with principal frequency increasing
%%% from f0 to (f0 + fstep time) over time seconds
fs = 8000; 
Ts = 1 / fs;
tmax = 5;
t = 0 : Ts : tmax;

f1 = 0;
f2 = fs/2;
mu = (f2 - f1) / (2*tmax);
x = cos(2*pi*f1*t + 2*pi*mu*(t.^2));

f0 = fs / 1000;
lowfcosines = zeros(1, length(t(1:1600)));
for n = 0 : 10
f1 = n*f0;
lowfcosines = lowfcosines + cos(2*pi*f1*t(1:1600));
end
%%
%%% Plot spectrogram of signal
blockSize = 1024; overlap = 1023;
x(1.4*fs+1:1.6*fs) = lowfcosines;
x(1.6*fs:end) = x(1.6*fs:end)./1000;
spectrogram(x, blockSize, overlap, blockSize, fs, 'yaxis');