close all;
fn=44100/2;
h=firls(950,[0/fn 1800/fn 2000/fn 4000/fn 4200/fn 1],[1 1 0 0 1 1]);
figure(3); 
freqz(h,1,1024,fn*2);