% Run the MATLAB filter design and analysis tool to design
% an FIR filter and export the coefficients
tic;
% FIR filter length is the filter order + 1
FIRlength = length(Num30); 
x_buffer = zeros(1,FIRlength);      % Buffer to store input

fs = 48000;      % Sampling frequency
Ts = 1/fs;       % Sampling period
T = Ts:Ts:1;     % Time duration of signal

%% cosine with single tone
f0 = 10000;         % Desired frequency
x = cos(2*pi*f0*T); % Generate cosine values using function call

%% FIR Filter
y_filtered = zeros(1,length(T));   % Store output for one bufffer

for t = 1:length(T)

    x_buffer(1) = x(t);            % Get new input at first position

    % Compute discrete-time convolution
    y = 0;
    for i = 1:FIRlength
        y = y + x_buffer(i)*Num30(FIRlength-i+1); 
    end

    % Shift all elements by one to get the next input
    for i = FIRlength:-1:2
        x_buffer(i) = x_buffer(i-1); 
    end
 
    y_filtered(t) = y;
end

%% For linear phase FIR filters, group delay is the filter order / 2
%% or equivalently (length - 1)/2.  Group delay is an integer for
%% odd length filters and a half sample index for even length filters.
GroupDelay = (FIRlength - 1)/2; 
GroupDelayAdj = floor(GroupDelay);

%% Compute gain from input to output using peak-to-peak values
VppOutput = max(y_filtered(1+GroupDelayAdj:end)) - min(y_filtered(1+GroupDelayAdj:end));
VppInput= max(x(1:end-GroupDelayAdj)) - min(y_filtered(1:end-GroupDelayAdj));
gain = VppOutput / VppInput;
gain_dB = 20*log10(gain); % gain in dB scale

figure
plot(T, y_filtered);
axis([-inf inf -1 1])

%% FFT
n = length(T);
f = fftshift(fft(y_filtered));
toc;
figure
plot(-fs/2:fs/n:(fs/2-fs/n), 10*log10(abs(f)))