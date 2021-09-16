clc; clear all; close all;
state = uint32(5);
bitarray = dec2bin(state);
bit3 = bitshift(bitand(4, state), -2);
T = 100;
states = zeros(1,T);
PN = zeros(1, T);
for t = 1:T
        [new, state] = SSRG_update(state);
        PN(t) = new;
        states(t) = state;
end
stem(1:T, PN);
states
statebin = dec2bin(states)
function [new, state] = SSRG_update(state);
    dec2bin(state)
    new = xor(bitand(bitshift(state, 0),1),bitand(bitshift(state, -3),1));
    state = bitshift(state, -1);
    state = bitset(state, 5, new);
    new
end