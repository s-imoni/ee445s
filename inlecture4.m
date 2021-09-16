% Consider performing an iterative maximization of
% J(x) =8 - x2 + 6 cos(6 x)
% via the steepest descent algorithm (JSK equation (6.5) on page 116)
% with the sign on the update reversed from negative to positive so that
% the algorithm will maximize rather than minimize; i.e.
% x[k+1] = x[k] + u dJ(x) / dx where x = x[k]
% a. Visualize and analyze the shape of the objective function J(x).
%     1) Plot J(x) for -5 < x < 5. Give the Matlab code for your answer.
x = [-5 : 0.01 : 5];
J = 8 - x.^2 + 6*cos(6.*x);
plot(x, J);
%     2) Describe the plot.
%       Big Picture: It's a concave down parabora. As cosine is added to it
%       there are a bunch of oscillations (like the cosine graph has).
%       There are multiple local minima and maxima.
%    3) How many local maxima do you see?
%        9 peaks + 2 end point
%     4) Of these local maxima, how many are global maxima?
%        Just 1 at X = 0
% b. Derive the steepest descent update equation
%     dJ/dx = -2x - 36*sin(6*x)
% and modify the code below to include the derivate of J(x)
% polyconverge.m find the maximum of J(x)=x via steepest descent
N=50;                      % number of iterations
mu=0.001;                % algorithm stepsize
x=zeros(1,N);              % initialize sequence of x values to zero
x(1)=0.7;                 % starting point x(1)
for k=1:N-1
  x(k+1)= x(k) + (-2*x(k) - 36*sin(6*x(k)))*mu;    % update equation
end
figure();
stem(x);          % to visualize approximation
x(N)
% c. Implement the steepest descent algorithm in Matlab with x[0] = 0.7.
%     1) To what value does the steepest descent algorithm converge?
%          x = 1.0376
%     2) Is the convergent value of x in the global maximum of J(x)? Why or why not?
%          No. The global max is at x = 0. It just went to the closest peak
%          and not the global max. 