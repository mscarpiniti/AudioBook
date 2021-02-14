% Esempio di implementazione di un algoritmo per la riverberazione che
% utilizza un filtro all-pass in versione on-line.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
g = 0.7;
D = 0.1*Fs;
y = zeros(size(x));
buffer = zeros(D, 1);

% Filtro all-pass
for n = 1:length(x)
    temp = buffer(D) + g*x(n);
    buffer = [x(n) - g*temp; buffer(1:D-1)];
    y(n) = temp;
end

% Ascolto del risultato
soundsc(y, Fs);