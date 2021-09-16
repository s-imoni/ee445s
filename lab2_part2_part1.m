fs = 8000;                    %%% sampling freq. Hz
fDesired = 500;               %%% desired freq. Hz
w0 = 2*pi*fDesired/fs;        %%% discrete-time freq.
N0 = fs / gcd(fDesired, fs);  %%% fundamental period

buffer_size = 2^10;
tmax = 2;
num_frames = ceil(tmax*fs/buffer_size);
N = num_frames*buffer_size;
n = 1:N;
y = cos(w0*n)';

deviceWriter = audioDeviceWriter(fs,'BufferSize',buffer_size);
profile off
profile on -timer 'cpu'
for i_frame = 1:num_frames
    first_ind = 1 +  (i_frame-1)*buffer_size;
    last_ind = i_frame*buffer_size;
    frame = y(first_ind:last_ind);
    deviceWriter(frame);
end
profile viewer;