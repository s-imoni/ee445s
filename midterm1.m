close all
figure;
x = sqrt(.5)
%z0 = -.9+.1*1j; z1 = -.9-.1*1j; p0 = .9+.1*1j; p1 = .9-.1*1j; % low pass
%p0 = -.9+.1*1j; p1 = -.9-.1*1j; z0 = .9+.1*1j; z1 = .9-.1*1j; % high pass
%z0 = -1*1j; z1 = -1*1j; p0 = .1*1j; p1 = .1*1j; % bandpass : done?
%z0 = 0*1j; z1 = 0*1j; p0 = -1*1j; p1 = -1*1j; % bandstop : done?
z0 = -1.25*1j; z1 = 1.25*1j; p0 = -.8*1j; p1 = .8*1j; % all pass
%z0 = x+x*1j; z1 = x-x*1j; p0 = .9*x-.9*x*1j; p1 = .9*x+.9*x*1j; % notch
numer = [1 -(z0+z1) z0*z1];
denom = [1 -(p0+p1) p0*p1];
z = 1; zvec = [ 1 z^(-1) z^(-2) ]';
gain = (denom*zvec) / (numer*zvec);
freqz( gain*numer, denom )
figure;
zer = [z0; z1]
pol = [p0; p1]
zplane(zer, pol)
