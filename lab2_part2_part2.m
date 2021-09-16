clear all; close all;
N = 16000;
%% 1. Fill up these fields based on the instrunction.
fs = 8000;                %%% sampling freq. Hz
fDesired =  1000;         %%% desired freq. Hz
w0 = (2*pi)*(1/8) ;       %%% discrete-time freq.
N0 = 8   ;                %%% fundamental period

%% 2. Compute N samples of the cosine signals using "function call" 
y_cos = zeros(1,N);
phase = 0;
%tic;
for i=1:N
    % Define a phase increment here
    % w0 = phase increment
    phase = phase + w0;
    % Increase the phase by the increment
    if (phase >= 2*pi)
        phase = phase - 2*pi;
    end
   
    y_cos(i) = cos(phase);
    % store the corresponding cosine value
end
%toc;
figure;
stem(y_cos(1:100));
xlabel("sample #");
ylabel("value");
title("function call");

%% 3. Compute N samples of the cosine signals using "look-up table" 
y_cos = zeros(1,N);
phase = 0;
LUT = zeros(1, N0);
%tic;
%profile on -timer 'cpu'
for i=1:N0
    % Define a phase increment here
    % w0 = phase increment
    phase = phase + w0;
    % Increase the phase by the increment
    if (phase >= 2*pi)
        phase = phase - 2*pi;
    end
   
    LUT(i) = cos(phase);
    % store the corresponding cosine value
end
% Fill up the LUT, you may use the same method as the one in function call,
% but with differnt buffer size!
% For each discrete time, call a value from LUT. 
% Avoid the use of mod() operator.
idx = 0;
for i=1:N
    idx = idx + 1;
    if(idx > N0)
        idx = idx - N0;
    end   
    y_cos(i) = LUT(idx); % store the corresponding cosine value
end
%profile off
%profile viewer
%toc;
figure;
stem(y_cos(1:100));
sound(10*y_cos, fs);
xlabel("sample #");
ylabel("value");
title("LUT");


%%%%%%%%%%%%%%%%% Not Periodic Signal %%%%%%%%%%%%%
fs = 8000 ;                  %%% sampling freq. Hz
fDesired =  3000/(2*pi) ;    %%% desired freq. Hz
w0 = (2*pi)*(fDesired/fs);  %%% discrete-time freq.
%%% fundamental period... does not exist
y_cos = zeros(1,N);
phase = 0;
for i=1:N
    % Define a phase increment here
    % w0 = phase increment
    phase = phase + w0;
    % Increase the phase by the increment
    if (phase >= 2*pi)
        phase = phase - 2*pi;
    end
    y_cos(i) = cos(phase);
    % store the corresponding cosine value
end
figure;
stem(y_cos(1:100));
xlabel("sample #");
ylabel("value");
title("function call with aperiodic");




