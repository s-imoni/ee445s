profile on -timer 'cpu'
for t = 1:10000
    sin(t);
end
profile off
profile viewer
% close all; clear all; clc;
% %%% Code to generate an array of discrete-time
% %%% cosine and sine signals one sample at a time.
% %%% Arrays are pre-allocated for efficiency.
% fs = 8000;                    %%% sampling freq. Hz
% fDesired = 1000;              %%% desired freq. Hz
% fDesired2 = 2000;              %%% desired freq. Hz
% w0 = 2*pi*fDesired/fs;        %%% discrete-time freq.
% w02 = 2*pi*fDesired2/fs;        %%% discrete-time freq.
% N0 = fs / gcd(fDesired, fs);  %%% fundamental period
% N02 = fs / gcd(fDesired2, fs);
% N = 50;                       %%% samples to plot
% savedcos = cos(w0);
% savedcos2 = cos(w02);
% phase = 0;
% phase2 = 0;
% y_cos = zeros(1,N);           %%% pre-allocate array
% y_cos2 = zeros(1,N);           %%% pre-allocate array
% 
% y_cos(1) = 1;
% y_cos(2) = savedcos;
% y_cos2(1) = 1;
% y_cos2(2) = savedcos2;
% %%% Compute N samples of the cosine and sine signals
% for i=3:N
% 
%     y_cos(i) = savedcos*2*y_cos(i-1)-y_cos(i-2);
%     y_cos2(i) = savedcos2*2*y_cos2(i-1)-y_cos2(i-2);
% end
% %%
% 
% figure;
% subplot(1,2,1)
% stem(1:N, y_cos)
% title(['cos(2$\pi$(', num2str(fDesired),'/', num2str(fs),')n)'], 'Interpreter','latex')
% xlabel( strcat(num2str(N0), ' samples in fundamental period') );
% grid on
% 
% subplot(1,2,2)
% stem(1:N, y_cos2)
% title(['cos2(2$\pi$(', num2str(fDesired2),'/', num2str(fs),')n)'], 'Interpreter','latex')
% xlabel( strcat(num2str(N02), ' samples in fundamental period') );
% grid on
