x_sc = uint32(5);
x_ds = uint32(5);
T = 100;
input = randi([0, 1], 1, T);
recovered_seq = [];
scrambled_seq = [];

for t = 1:T
    [scrambled, x_sc] = scrambler(input(t), x_sc)
    scrambled_seq = [scrambled_seq, scrambled];
    [descrambled, x_ds] = descrambler(scrambled, x_ds);
    recovered_seq = [recovered_seq, descrambled];
end

subplot(3,1,1);
stem(1:T, input);
axis([-inf inf -1 2]);
title('input sequence');
grid on;

subplot(3,1,2);
stem(1:T, scrambled_seq)
axis([-inf inf -1 2]);
title('scrambled sequence')
grid on

subplot(3,1,3);
stem(1:T, recovered_seq);
axis([-inf inf -1 2]);
grid on
title('recovered sequence')


function [scrambled, x_sc] = scrambler(input, x_sc)
bit5 = bitshift(x_sc, 0);
bit5 = bitand(bit5, 1);

bit2 = bitshift(x_sc, -3);
bit2 = bitand(bit2, 1);

tmp = xor(bit5,bit2);
scrambled = xor(tmp, input);

x_sc = bitshift(x_sc, -1);
x_sc = bitset(x_sc, 5, tmp);


end

function [descrambled, x_ds] = descrambler(scrambled, x_ds)
bit5 = bitshift(x_ds, 0);
bit5 = bitand(bit5, 1);

bit2 = bitshift(x_ds, -3);
bit2 = bitand(bit2, 1);

tmp = xor(bit5,bit2);
descrambled = xor(tmp, scrambled);

x_ds = bitshift(x_ds, -1);
x_ds = bitset(x_ds, 5, tmp);


end

