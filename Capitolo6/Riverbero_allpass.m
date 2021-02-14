% Esempio di implementazione di un algoritmo per la riverberazione che
% utilizza un filtro all-pass in versione off-line.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
g = 0.7;
D = 0.1*Fs;
a = zeros(1, D);
b = zeros(1, D);
b(1) = g;
b(D) = 1;
a(1) = 1;
a(D) = g;

% Filtraggio
y = filter(b, a, x);

% Ascolto del risultato
soundsc(y, Fs);