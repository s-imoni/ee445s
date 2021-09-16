% Run the MATLAB filter design and analysis tool to design
% an FIR filter and export the coefficients
fs = 48000;
buffer_size = 2^12;
tmax = 2;
num_frames = ceil(tmax*fs/buffer_size);
N = num_frames*buffer_size;
x = 0.01*randn(N,1);

deviceWriter = audioDeviceWriter(fs,'BufferSize',buffer_size);
profile off
profile on -timer 'cpu'
for i_frame = 1:num_frames
    first_ind = 1 +  (i_frame-1)*buffer_size;
    last_ind = i_frame*buffer_size;
    frame = x(first_ind:last_ind);
    % deviceWriter(frame);      %%% play the original signal  
    
    y = filter(Num,1,frame);
    %deviceWriter(y);          %%% play the filtered signal
end
profile viewer;
%figure; plot(y);
%figure; plot(x);
X = fftshift(fft(x));
Y = fftshift(fft(y));
figure; 
plot(10*log10(abs(X)));
xlabel("Hz");
ylabel("dB");
figure; 
plot(10*log10(abs(Y)));
xlabel("Hz");
ylabel("dB");

clear y;
