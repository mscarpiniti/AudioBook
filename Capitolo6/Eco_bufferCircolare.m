% Esempio di implementazione dell'effetto eco in modalità online
% utilizzando il buffer circolare.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
T = 1;  % Ritardo di 1 secondo
g = 0.5;
D = T*Fs;
LB = D;   % Lunghezza del buffer

buffer = zeros(LB, 1);
y = zeros(size(x));
pt = 1;   % Puntatore iniziale

for n = 1:length(x)      % Per ogni campione
    temp = buffer(pt);   % Si legge un campione dal buffer
    buffer(pt) = x(n) + g*temp;   % Si scrive nel buffer il valore elaborato
    y(n) = temp;    % Si definisce il campione di output
    pt = pt + 1;    % Si incrementa il valore del puntatore
    if pt > Lb
        pt = 1;
    end
end

soundsc(y, Fs);
