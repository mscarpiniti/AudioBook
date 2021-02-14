% Esempio di implementazione dell'effetto tremolo.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


[x, Fs] = audioread('audio.wav');

f0 = 12;       % Frequenza modulante (LFO)
alpha = 0.5;   % Ampiezza del tremolo
f0 = f0/Fs;    % Frequenza normalizzata
y = zeros(size(x));

for n=1:length(x)
    y(n) = (1 + alpha*cos(2*pi*f0*n))*x(n);   % Tremolo Eq. (6.7)
end

soundsc(y, Fs);