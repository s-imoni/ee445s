clc; close all; clear all;
% clockrec4thpower.m: clock recovery maximizing output power
% prepare transmitted signal
n=5000; % number of symbols
m=2; % oversampling factor (samples/symbol)
constel=2; % 2-pam constellation
beta=0.2; % rolloff parameter for srrc
l=50; % 1/2 length of pulse shape (in symbols)
chan=[1]; % T/m "channel"
toffset= 0.5; % initial timing offset
% s=srrc(syms, beta, P, t_off);
% Generate a Square-Root Raised Cosine Pulse
pulshap=srrc(l,beta,m,toffset); % srrc pulse shape
s=pam(n,constel,1); % random data sequence with var=1
sup=zeros(1,n*m); % upsample the data by placing...
sup(1:m:end)=s; % ... p zeros between each data point
hh=conv(pulshap,chan); % ... and pulse shape
r=conv(hh,sup); % ... to get received signal
matchfilt=srrc(l,beta,m,0); % filter = pulse shape
x=conv(r,matchfilt); % convolve signal with matched filter
% run symbol clock recovery algorithm
epsilon = 0.01;
N = 40;
%mubar = [0.001 0.01 0.05 5];
mu_bar = 0.001;
%mu = 4*mubar/(epsilon*N); % algorithm stepsize
step_size = 4*mu_bar/(epsilon*N);

% for count=1:length(mu)
% tnow=l*m+1; tau=0; xs=zeros(1,n); % initialize variables
% tausave=zeros(1,n); tausave(1)=tau; i=0;
% JFP=zeros(1,n);
% epsilon=0.01;
% tmax=length(x) - l*m - (N+1)*m; % max time for simulation
% while tnow < tmax % run iterations
% i=i+1;
% xs(i)=interpsinc(x,tnow+tau,l); % interp at tnow+tau
% % Update equation for tau
% dJFP_dtau = 0; % dJ_FP(tau) / d(tau)
% for k0 = 1 : N
% x_deltap = interpsinc(x,tnow+k0*m+tau,l); % value to right
% x_deltam = interpsinc(x,tnow+k0*m+tau-epsilon,l); % value to left
% dx = x_deltap - x_deltam; % approximate dx/dtau
% dJFP_dtau = dJFP_dtau + (x_deltap^3)*dx; % derivative
% end
% tau = tau - mu(count) * dJFP_dtau; % update tau
% tnow=tnow+m; tausave(i)=tau; % save for plotting
% end
% % plot results
% figure(count);
% subplot(2,1,1), plot(xs(1:i-9),'b.') % plot constellation diagram
% grid on;
% title_str = ['constellation diagram, mu = ' num2str(mu(count))];
% title(title_str);
% ylabel('estimated symbol values')
% subplot(2,1,2), plot(tausave(1:i-9)) % plot trajectory of tau
% grid on;
% ylabel('offset estimates'), xlabel('iterations')
% end

tnow=l*m+1; tau=0; xs=zeros(1,n);   % initialize variables
tausave=zeros(1,n); tausave(1)=tau; i=0;
%mu=0.05;                            % algorithm stepsize
%delta=0.1;                          % time for derivative
while tnow<length(x)-(l+N+1)*m            % run iteration
  i=i+1;
  xs(i)=interpsinc(x,tnow+tau,l);   % interp at tnow+tau
  der = 0;
  for k = 1:1:N
    x_deltap=interpsinc(x,tnow+tau+k*m,l);  % value to right
    x_deltam=interpsinc(x,tnow+tau+k*m-epsilon,l);  % value to left
    dx=x_deltap-x_deltam;             % numerical derivative
    der = der + (x_deltap^3)*dx;
  end
  tau=tau-step_size*der;              % alg update (energy)
  tnow=tnow+m; tausave(i)=tau;      % save for plotting
end

% plot results
subplot(2,1,1), plot(xs(1:i-2),'b.')    % plot constellation diagram
title('constellation diagram');
ylabel('estimated symbol values')
subplot(2,1,2), plot(tausave(1:i-2))               % plot trajectory of tau
ylabel('offset estimates'), xlabel('iterations')

function s=srrc(syms, beta, P, t_off);

% s=srrc(syms, beta, P, t_off);
% Generate a Square-Root Raised Cosine Pulse
%      'syms' is 1/2 the length of srrc pulse in symbol durations
%      'beta' is the rolloff factor: beta=0 gives the sinc function
%      'P' is the oversampling factor
%      't_off' is the phase (or timing) offset

if nargin==3, t_off=0; end;                       % if unspecified, offset is 0
k=-syms*P+1e-8+t_off:syms*P+1e-8+t_off;           % sampling indices as a multiple of T/P
if (beta==0), beta=1e-8; end;                     % numerical problems if beta=0
s=4*beta/sqrt(P)*(cos((1+beta)*pi*k/P)+...        % calculation of srrc pulse
  sin((1-beta)*pi*k/P)./(4*beta*k/P))./...
  (pi*(1-16*(beta*k/P).^2));
end

% seq=pam(len,M,Var);
% Create an M-PAM source sequence with
% length 'len'  and variance 'Var'
function seq=pam(len,M,Var);
seq=(2*floor(M*rand(1,len))-M+1)*sqrt(3*Var/(M^2-1));
end

function y=interpsinc(x, t, l, beta)
% y=interpsinc(x, t, l, beta)
% interpolate to find a single point using the direct method
%        x = sampled data
%        t = place at which value desired
%        l = one sided length of data to interpolate
%        beta = rolloff factor for srrc function
%             = 0 is a sinc
if nargin==3, beta=0; end;           % if unspecified, beta is 0
tnow=round(t);                       % create indices tnow=integer part
tau=t-round(t);                      % plus tau=fractional part
s_tau=srrc(l,beta,1,tau);            % interpolating sinc at offset tau
x_tau=conv(x(tnow-l:tnow+l),s_tau);  % interpolate the signal
y=x_tau(2*l+1);                      % the new sample
end