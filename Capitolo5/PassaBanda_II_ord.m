% Implementazione del filtro passa-banda del II ordine.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

f0 = 2000;
fb = 400;
k = tan(pi*f0/Fs);
Q = f0/fb;
b = [k/(k^2*Q+k+Q), 0, -k/(k^2*Q+k+Q)];
a = [1, 2*Q*(k^2-1)/(k^2*Q+k+Q), (k^2*Q-k+Q)/(k^2*Q+k+Q)];
y = filter(b, a, x);

freqz(b, a);
title('Filtro del II ordine');
