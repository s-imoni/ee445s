close all
% Run the MATLAB filter design and analysis tool to design
% an IIR filter and export the coefficients to Num and Den variable (or B and A)

N = 6; % order of IIR filter

% IIR filter length is the filter order + 1 %B = [1, -1]; % numerator coefficients
B = Num; %A = [1, -0.9]; % denominator coefficients
A = Den;
x = [0, 0, 0, 0, 0, 0, 0]; % input value (buffered)
y = [0, 0, 0, 0, 0, 0, 0]; % output values (buffered)

fs = 48000;         % Sampling frequency
Ts = 1/fs;          % Sampling period
T = Ts:Ts:1;        % Time duration of signal

%% sum of 1 kHz cosine and its harmonics up to 24 kHz. 
f0 = 1000;
signal = cos(2*pi*f0*T);
for j = 2:24
    signal = signal + cos(2*pi*j*f0*T);
end

%% IIR Filter
y_filtered = zeros(1,length(T));   % Store output for one bufffer

for t = 1:length(T)
    x(1) = signal(t); % get input data sample as current input value
    
    %y(1) =  B(1)*x(1) + B(2)*x(2) -A(2)*y(2); % IIR filtering
    %x(2) = x(1); % update of state variables
    %y(2) = y(1);
    [ret, x, y] = IIR_DF(A, B, x, y, N); 
    y_filtered(t) = y(1);
end


%% Compute gain from input to output using peak-to-peak values
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


function [y_filtered, x, y] = IIR_DF(A, B, x, y, N)
    y_filtered = B(1)*x(1);
    for i = 2:(N+1)
        y_filtered = y_filtered + B(i)*x(i) - A(i)*y(i);
    end
    
    y(1) = y_filtered;
    
    for j = (N):-1:1
        y(j+1) = y(j);
        x(j+1) = x(j);
    end
end