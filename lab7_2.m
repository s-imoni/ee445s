clear
close all
clc

[audios, fs] = audioread('twosignals.wav'); 
T = length(audios);
sound(audios, fs);
pause(T/fs + 1);
f0 = 15; % set f0

BUFFERLENGTH = 4800;
gain = 0.75;

oldest = 1;

buffer = zeros(1, BUFFERLENGTH);
output = zeros(1,T);


for t = 1:T
    input = audios(t);
    buffer(oldest+1) = input;
    oldest = mod(oldest + 1, BUFFERLENGTH);
    output(t) = input + gain*buffer(oldest+1);
end

for t = 1:T
    input = audios(t);
    b = 0.5*(1-cos(2*pi*f0/fs*t));
    b2 = round(b*48);
    buffer(oldest+b2) = input;
    oldest = mod(oldest+b2, BUFFERLENGTH);
    
    output(t) = input + gain*buffer(oldest+1);
end

sound(output, fs);

subplot(2,1,1)
stem(audios)
subplot(2,1,2)
stem(output)


%% 
subplot(2,1,1)
Y = fft(audios);
P2 = abs(Y/T);
P1 = P2(1:T/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(T/2))/T;
plot(f,P1) 

subplot(2,1,2)
Y = fft(output);
P2 = abs(Y/T);
P1 = P2(1:T/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(T/2))/T;
plot(f,P1)