clc; close all; 
totalCorrect = 0;
totalRuns = 10000;
for run = 1:totalRuns
% Begin correx.m from Software Receiver Design book
header = [1 1 -1 -1 1 1 -1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 -1 1 1 -1 -1 -1 1 1 1];
%header = round(ones(1,31)); % header is a predefined string
loc=30; r=25; % place header in position loc
data=[ sign(randn(1,loc-1)) header sign(randn(1,r)) ]; % generate signal
sd=2; data=data+sd*randn(size(data)) ; % add noise
y=xcorr(header, data) ; % do cross correlation
[m, ind]=max(y); % location of largest correlation
headstart=length(data)-ind+1; % place where header is detected
% End of code from Software Receiver Design book
if ( loc == headstart )
totalCorrect = totalCorrect + 1;
end
end
totalCorrect / totalRuns
%h = [1 1 -1 -1 1 1 -1 1 -1 -1 1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 -1 1 1 -1 -1 -1 1 1 1];

subplot(3,1,1), stem(header)           % plot header
title('Header')
subplot(3,1,2), stem(data)             % plot data sequence
title('Data with embedded header')
subplot(3,1,3), stem(y)                % plot correlation
title('Correlation of header with data')



