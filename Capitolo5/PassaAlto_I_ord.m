% Implementazione del filtro passa-alto del I ordine.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

ft = 2000;
k = tan(pi*ft/Fs);
b = [1/(k+1), -1/(k+1)];
a = [1, (k-1)/(k+1)];
y = filter(b, a, x);

freqz(b, a);
title('Filtro del I ordine');
