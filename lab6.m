fs = 48000;
%% record 10 seconds of audio using default sound device
rec = audiorecorder(fs,16,1);
recordblocking(rec, 10);
RX = getaudiodata(rec)';

%% save the recorded audio to the file RX.mat
save RX RX

