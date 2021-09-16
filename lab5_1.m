% symbol generation
clear all; close all; clc;
input = round(rand(1, 200));
bpsk = 2*input-1;

% raised cosine filtering
coef = rcosdesign(1, 8, 20, 'normal');
upsampled_signal = upsample(bpsk, 20);
y = conv(upsampled_signal, coef);
bpsk_pad = [zeros(1, 80) upsampled_signal];
figure; plot(5*y); hold on; stem(bpsk_pad); title("alpha = 1"); xlim([1, 400]);
figure; plot(5*y); hold on; stem(bpsk_pad); title("alpha = 1");
eyediagram(y, 40, 20);
figure; freqz(coef);
figure; stem(coef);


% raised cosine filtering with alpha = 0.125
coef = rcosdesign(0.125, 8, 20, 'normal');
upsampled_signal = upsample(bpsk, 20);
y = conv(upsampled_signal, coef);
figure; plot(5*y); hold on; stem(bpsk_pad); title("alpha = 0.125"); xlim([1, 400]);
figure; plot(5*y); hold on; stem(bpsk_pad); title("alpha = 0.125");
eyediagram(y, 40, 20);
figure; freqz(coef);
figure; stem(coef);


% alpha = 1, less isi, not as good of a low pass