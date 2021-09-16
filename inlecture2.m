% In-Lecture Assignment related to Homework Problem 3.3 IIR Filter Design
% Design of a bandstop IIR filter to relieve symptoms of tinnitus (“ringing of the ears”).
% This assignment relates to parts (a) and (b) of homework problem 3.3.
% Here are the bandstop filter specifications for your design:
% For frequencies 0 Hz to 0.6 fc, passband ripple should be no greater than 1 dB.
% For frequencies (2/3) fc to (4/3) fc, stopband attenuation should be at least 80 dB.
% For frequencies above 1.4 fc, passband ripple should be no greater than 1 dB
% Please use a tinnitus frequency fc of 3000 Hz and a sampling rate fs of 44100 Hz.
% Use the filter design and analysis tool (fdatool) or filter designer in Matlab.
% (a) Use the Elliptic (equiripple) design method to design an IIR filter to meet the specification.
% 0.6*fc = 1800, 2/3*3000 = 2000, 4/3*3000 = 4000, 1.4*3000 = 4200
%      1. Give the filter order. How many biquads?
%           Filter Order: 20, Biquads: 10
%      2. Are all of the poles inside the unit circle for bound-input bounded-output (BIBO) stability?
%           Yes
%      3. Describe the pole-zero plot and connect poles/zeros to filter passbands/stopbands
%           The poles/zeros are conjugate pairs and concrated in the right
%           two quadrants. 
%           The poles are at angles corresponding to passband frequencies.
%           The zeroes are at angles corresponding to stopband frequencies.
%      4. Give the minimum and maximum value of the group delay over 0-1 kHz
%           10 & 21 samples
%      5. At what frequency does the peak group delay value occur?
%           1800 Hz and 4200 Hz
% (b) Convert the IIR filter structure to be a single direct form section. In fdatool, this accomplished via the “Convert to a Single Section” under the Edit menu.
%      1. Are any poles outside the unit circle? If so, how many? Why?
%          4, Poly expansion. There is a loss of accuracy in the feedback
%          coefficients because of the precision in the addition and
%          multiplication. 
%      2. Describe any differences in the magnitude response vs. part (a).
%           The single section implementation does not meet the
%           specifications for the passband described above. 