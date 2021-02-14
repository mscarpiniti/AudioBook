% Esempio di implementazione dell'effetto eco in modalità offline.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
T = 1;     % Ritardo di 1 secondo
g = 0.5;
D = T*Fs;  % Ritardo in campioni

a = zeros(1, D+1);
a(1)   = 1;
a(end) = -g;

y = filter(1, a, x);

soundsc(y, Fs);