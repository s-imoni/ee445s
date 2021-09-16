% Run the MATLAB filter design and analysis tool to design
% an FIR filter and export the coefficients to Num variable

% FIR filter length is the filter order + 1
FIRlength = length(Num30); 
x_buffer = zeros(1,FIRlength);   % Buffer to store input

f0 = 1000
fstep = 24000;
fs = 48000;      
Ts = 1/fs;      
T = Ts:Ts:1;
chirpsignal = cos(2*pi*(f0+T.*0.5*fstep).*T);
x = chirpsignal

%% FIR Filter
y_filtered = zeros(1,length(T));   % Store output for one bufffer
profile on -timer 'cpu'
oldest = 1;         % Points to oldest sample
for t = 1:length(T)

    x_buffer(oldest) = x(t);  % Put new input where oldest input is

    y = 0;
    for i = 1:FIRlength
        % index x_buffer starting at "oldest" where we placed new input
        idx = oldest+i-1;

        if idx > FIRlength
            idx = idx - FIRlength; % modulus operations
        end

        % compute one term of discrete-time convolution
        y = y + x_buffer(idx)*Num30(FIRlength-i+1); 
    end
    
    y_filtered(t) = y;
    
    % update of the oldest input. We no longer have shifters
    oldest = oldest + 1; 
    if oldest == (FIRlength+1)
        % If oldest index exceeds FIR filter length, perform modulo op
        oldest = 1; 
    end
end
 profile off;  profile viewer;
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
figure
plot(-fs/2:fs/n:(fs/2-fs/n), 10*log10(abs(f)))