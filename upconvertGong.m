%%% Read gong signal
%%% Dominant frequencies are 520 (C5), 630 and 660 Hz (E5) from
%%% ploting the spectrum: plotspec(basebandInput, 1/fs)
%%% Maximum frequency of interest, f1, is 660 Hz.
[basebandInput, fs] = audioread('gong.wav');
basebandInput = basebandInput';
f1 = 660;

Ts = 1/fs;                           %%% Sampling time
numSamples = length(basebandInput);
n = 1 : numSamples;
t = n * Ts;
tmax = Ts * numSamples;

%%% Upconvert using sinusoidal amplitude modulation
%%% to be centered at frequency fc
fc = 4*f1;
carrier = cos(2*pi*fc*t);
modulated = (basebandInput + 1) .* carrier;
%modulated = basebandInput .* carrier;

% part a
% play original signal
sound(basebandInput, fs);
pause(tmax+1);
%downconversion
carrier = cos(2*pi*fc*t);
modulateAgain = (modulated).* carrier;

%low pass filter
FIRlength = floor(fs/f1);
if 2*floor(FIRlength/2) == FIRlength
  FIRlength = FIRlength - 1;
end
lowpassCoeffs = ones(1, FIRlength) / FIRlength;
basebandOutput = 2*filter(lowpassCoeffs, 1, modulateAgain);
basebandOutput = basebandOutput-mean(basebandOutput);
% mean squared error
N = (FIRlength-1)/2;
sum((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)
mean((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)
%part a result
sound(basebandOutput, fs);
pause(tmax+1);

% PART A QUESTIONS:
% i: 0.0089
% ii: There is an high frequency noise that overshadows the gong that is
% now very quiet. 

%part b
%squaring device
modulateAgain = modulated.^2;
figure;
plotspec(modulateAgain, 1/fs);
% low pass filter
FIRlength = floor(fs/(2*f1));
if 2*floor(FIRlength/2) == FIRlength
  FIRlength = FIRlength - 1;
end
lowpassCoeffs = ones(1, FIRlength) / FIRlength;
basebandOutput = 2*filter(lowpassCoeffs, 1, modulateAgain);
% plot
figure;
plotspec(basebandOutput, 1/fs);
% final part b output
sound(basebandOutput, fs);
pause(tmax+1);
% mean squared error
N = (FIRlength-1)/2;
sum((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)
mean((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)

% PART B QUESTIONS:
% i: 1.0361
% ii: Sounds a little distorted, maybe a little bit like a guitar string or
% an alarm. 
% iii: They doubled, as squaring in the time domain results in *2 in frequency domain.


% part c: sqrt
basebandOutput = basebandOutput.^.5;
sound(basebandOutput, fs);
pause(tmax+1);
% mean squared error
N = (FIRlength-1)/2;
sum((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)
mean((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)

% PART C QUESTIONS:
% i: 1.0076
% ii: Very similar to part b, but quieter.


% part d
% remove dc offset
basebandOutput = basebandOutput-mean(basebandOutput);
sound(basebandOutput, fs);
pause(tmax+1);
% mean squared error
N = (FIRlength-1)/2;
sum((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)
mean((basebandOutput(N+1:length(basebandOutput))-basebandInput(1:length(basebandOutput)-N)).^2)

% PART D QUESTIONS:
% i: 0.0011


% finished


