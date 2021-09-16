close all
N = 2; % order of IIR filter
M = 3; % # of biquads
x = zeros(M, N+1); % input value (buffered)
y = zeros(M, N+1); % output values (buffered)
B = SOS(:, 1:3) % left half
A = SOS(:, 4:6) % right half
fs = 48000;         % Sampling frequency
Ts = 1/fs;          % Sampling period
T = Ts:Ts:1;        % Time duration of signal
f0 = 1000;
signal = cos(2*pi*f0*T);
for j = 2:24
    signal = signal + cos(2*pi*j*f0*T);
end
y_filtered = zeros(1,length(T));   % Store output for one bufffer
for t = 1:length(T)
    x(1,1) = signal(t); % get input data sample as current input value 
    for m = 1:M      
        [x, y] = biquad(x, y, B, A, G, m); 
        %setting rest of x
        if(m > 1)
            x(m,1) = y(m-1,1);
        end
    end
    y_filtered(t) = y(M,1); 
end
VppOutput = max(y_filtered(1+(N+1):end)) - min(y_filtered(1+(N+1):end));
VppInput= max(y_filtered(1:end-(N+1))) - min(y_filtered(1:end-(N+1)));
gain = VppOutput / VppInput;
gain_dB = 20*log10(gain); % gain in dB scale
figure
plot(T, y_filtered);
axis([-inf inf -1 1])
%% FFT
n = length(T);
figure
subplot(1,2,1)
f = fftshift(fft(signal));
plot(-fs/2:fs/n:(fs/2-fs/n), 10*log10(abs(f)))
subplot(1,2,2)
f = fftshift(fft(y_filtered));
plot(-fs/2:fs/n:(fs/2-fs/n), 10*log10(abs(f)))
function [x, y] = biquad(x, y, B, A, G, m)
    out = B(m,1)*x(m,1)*G(m);   
    for i = 2:3
        out = out + B(m,i)*x(m,i) - A(m,i)*y(m,i);
    end
    y(m, 1) = out;    
    for i = 2:-1:1
        x(m,i+1) = x(m,i);
        y(m,i+1) = y(m,i);
    end
end