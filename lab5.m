clear; close all; clc
T = 200;
data = [-15000, 15000];
x = zeros(1,10);
samplesPerSymbol = 20;
state = uint32(5);
% alpha = 1 / 0.125
%B = rcosdesign(1, 8, 20, 'normal'); % pulses you use before u truncate response
B = rcosdesign(0.125, 8, 20, 'normal'); % pulses you use before u truncate response
output = zeros(1,T);
cosine = int32([1 0 -1 0]);
counter = 0;
for t = 1:T    
   if counter == 0 
       [symbol, state] = SSRG_update(state);
       x(1) = data(symbol+1);
   end 
   y = 0; 
   for i = 0:7
       y = y + x(i+1) * B(counter + samplesPerSymbol*i + 1);
   end   
   if counter == (samplesPerSymbol -1)
       counter = -1;     
       for i = 7:-1:1
           x(i+1) = x(i);
       end
   end  
   counter = counter + 1;  
   %output(t) = y*cosine(mod(t,4)+1);  
   output(t) = y;     
end
stem(1:T, output, '.-')
function [new, state] = SSRG_update(state);
    new = xor(bitand(bitshift(state, 0),1),bitand(bitshift(state, -5),1));
    state = bitshift(state, -1);
    state = bitset(state, 23, new);
end
