clear; close all; clc
T = 1000;
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
       %[symbol, state] = SSRG_update(state);
       if (0 == bitget(state,23))
           symbol = 1;
       else 
           symbol = 0;
       end
       state = bitshift(state, -1);
       state = bitset(state, 23, symbol);
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
%stem(1:T, output, '.-')

% taken from fdatool
SOS_h = [1,0,-1,1,-1.86313570437960,0.969067417193793];
SOS_b = [1,0,-1,1,-1.95754452892130,0.984414127416097];
G_h = [0.0154662914031035;1];
G_b = [0.00779293629195178;1];
B_b = SOS_b(:, 1:3); % left half
A_b = SOS_b(:, 4:6); % right half
B_h = SOS_h(:, 1:3); % left half
A_h = SOS_h(:, 4:6); % right half

% pass pam output to a new framwork
recovered_clock = sof(output, A_b, B_b, G_b);
recovered_clock = recovered_clock.^2;
recovered_clock = sof(recovered_clock, A_h, B_h, G_h);
figure
subplot(2,1,1)
stem(output);
title("PAM output");
xlim([500, 650]);
subplot(2,1,2)
stem(recovered_clock);
title("Recovered Clock");
xlim([500, 550]);

figure
subplot(2,1,1)
stem(output);
title("PAM output - zoomed out");
subplot(2,1,2)
stem(recovered_clock);
title("Recovered Clock - zoomed out");

function [y_filtered] = sof(input, A, B, G)
    M = 1; % of biquads
    x = zeros(M, 3); % input value (buffered)
    y = zeros(M, 3); % output values (buffered)
    y_filtered = zeros(1,length(input));   % Store output for one bufffer
    for t = 1:length(input)
        x(1,1) = input(t); % get input data sample as current input value 
        for m = 1:M      
            [x, y] = biquad(x, y, B, A, G, m); 
            %setting rest of x
            if(m > 1)
                x(m,1) = y(m-1,1);
            end
        end
        y_filtered(t) = y(M,1); 
    end
end

function [x, y] = biquad(x, y, B, A, G, m)
    out = B(m,1)*x(m,1)*G(m);   
    for i = 2:3
        out = out + B(m,i)*x(m,i) - A(m,i)*y(m,i);
    end
    y(m, 1) = out;    
    for i = 2:-1:1
        x(m,i+1) = x(m,i);
        y(m,i+1) = y(m,i);
    end
end

function [new, state] = SSRG_update(state);
    new = xor(bitand(bitshift(state, 0),1),bitand(bitshift(state, -5),1));
    state = bitshift(state, -1);
    state = bitset(state, 23, new);
end
