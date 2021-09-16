close all; clc; clear
% polyconverge.m find the minimum of J(x)=x^2-8x+16 via steepest descent
N=500; % number of iterations
mu=[-.01 0 .01 .1 1 10]; % algorithm stepsize
x=zeros(size(1,N)); % initialize x to zero
x(1)=5; % starting point x(1)
all = zeros(length(mu), N);
for i=1:length(mu)
for k=1:N-1
x(k+1)=(1-2*mu(i))*x(k)+14*mu(i); % update equation
end
all(i,:)= x;
end
subplot(3,2,1); plot (all(1,:)); title('mu = -0.01');
subplot(3,2,2); plot (all(2,:)); title('mu = 0');
subplot(3,2,3); plot (all(3,:)); title('mu = 0.01');
subplot(3,2,4); plot (all(4,:)); title('mu = 0.1');
subplot(3,2,5); plot (all(5,:)); title('mu = 1');
subplot(3,2,6); plot (all(6,:)); title('mu = 10');

figure;
N=[5 40 100 5000]; % number of iterations
mu=.01; % algorithm stepsize
x=zeros(1); % initialize x to zero
x(1)=5; % starting point x(1)
y = zeros(4);
for i=1:length(N)
for k=1:N(i)-1
x(k+1)=(1-2*mu)*x(k)+14*mu; % update equation
end
y(i)= min(x);
subplot(2,2,i); plot(x); title(strcat('Iterations, N = ',int2str(N(i))));
end

figure;
% polyconverge.m find the minimum of J(x)= x^2-14x+49 via steepest descent
N=600; % number of iterations
mu=.01; % algorithm stepsize
x=zeros(size(1,N)); % initialize x to zero
for i=1:100
x(1)=randi([-1000 1000],1,1); % starting point x(1)
for k=1:N-1
x(k+1)=(1-2*mu)*x(k)+14*mu;
end % update equation
plot (x);
hold on;
end
hold off;
title('Effect of Starting Point');
