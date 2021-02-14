% Esempio di implementazione dell'effetto eco in modalità online
% utilizzando il buffer lineare.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
T = 1;  % Ritardo di 1 secondo
g = 0.5;
D = T*Fs;

buffer = zeros(1, D);
y = zeros(size(x));

for n = 1:length(x)       % Per ogni campione
    temp = buffer(end);   % Si legge l'ultimo campione dal buffer
    buffer = [x(n) + g*temp; buffer(1:end-1)];  % Si scorre il buffer
    y(n) = temp;    % Si definisce il campione di output
end

soundsc(y, Fs);
