% Esempio di implementazione di un algoritmo per la riverberazione che
% utilizza filtri comb.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
g = 0.7;
D = 0.1*Fs;
a1 = zeros(1, D);
b1 = zeros(1, D);
a2 = zeros(1, D);

% Architettura di Figura 6.2(a)
b1(D) = 1;
a1(1) = 1;
a1(D) = g;
y1 = filter(b1, a1, x);

% Architettura di Figura 6.2(b)
b2 = 1;
a2(1) = 1;
a2(D) = -g;
y2 = filter(b2, a2, x);

% Ascolto del risultato
soundsc(y1, Fs);
soundsc(y2, Fs);