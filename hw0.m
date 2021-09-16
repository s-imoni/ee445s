% %% 1A
% 
% Ts = 0.01;
% t= -0.5 : Ts : 1.5;
% f0 = 10;
% x = sin(2*pi*f0*t);
% h = rectpuls(t-0.5);
% c = x .* h;
% figure
% plot(t,c)
% grid
% title('Truncated Sine')
% xlabel('t')
% ylabel('c(t)')
% 
% %% 1B
% 
% f0=5;
% f=[-20:0.1:20];
% C = j/2*exp(-j/2*(f+f0)).*sinc(f+f0) - j/2*exp(-j/2*(f-f0)).*sinc(f-f0);
% figure
% plot(f,abs(C))
% grid
% title('Plot of Magnitude of Fourier Transform of c(t)')
% xlabel('f (Hz)')
% ylabel('|C(f)|')
% 
% %% 4e
% 
% w0 = 0;
% n = [0:25];
% u = heaviside(n);
% x = cos(w0*n);
% h = x.*u;
% figure, stem(n,h);
% title('0')
% xlabel('n')
% ylabel('h[n]')
% 
% w0 = pi;
% n = [0:25];
% u = heaviside(n);
% x = cos(w0*n);
% h = x.*u;
% figure, stem(n,h);
% title('pi')
% xlabel('n')
% ylabel('h[n]')
% 
% w0 = pi/4;
% n = [0:25];
% u = heaviside(n);
% x = cos(w0*n);
% h = x.*u;
% figure, stem(n,h);
% title('pi/4')
% xlabel('n')
% ylabel('h[n]')


%clear all; close all; clc;

%% Code segment "a"

N = 100;

k = 1:N;

stepFloat = 0.1;

float1 = 0.0;

stepInt = 1;

int1 = 0;

%%

%% Code segment "b"

for i = 1:N

  float1 = float1 + stepFloat;

  int1 = int1 + stepInt;

end

count2 = stepFloat*N;

int2 = stepInt*N;

%%

%% Code segment "c"

if( float1 == count2 )

  disp('floating point equal');

else

  disp('floating point not equal');

end

%%

%% Code segment "d"

if( int1 == int2 )

  disp('fixed point equal');

else

  disp('fixed point not equal');

end

%%


