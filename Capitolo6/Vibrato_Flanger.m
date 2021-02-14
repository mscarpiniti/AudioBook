% Esempio di implementazione dell'effetto vibrato/flanger.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
K = 1;                   % K=1: flanger, K=0: vibrato
g = sqrt(2);             % Depth control
f0 = 2;                  % Frequenza dell'LFO
T = 7/1000;              % Ritardo dell'effetto
mD = 1;                  % Profondità effetto
D0 = round(T*Fs);        % Ritardo base in campioni
D1 = round(mD*D0);       % Ritardo variabile
f0 = f0/Fs;              % Frequenza normalizzata
L = length(x);           % Lunghezza del segnale
LB = 1 + D0 + D1;        % Lunghezza del buffer
buffer = zeros(LB, 1);   % Buffer
y = zeros(size(x));      % Segnale di uscita vibrato/flanger

% Applicazione effetto
for n = 1:L-1
    f_D = sin(2*pi*f0*n);      % Segnale dell'LFO, Eq. (6.4) e (5.52)
    D = 1 + D0 + D1*f_D;       % Eq. (6.4), il +1 per evitare lo zero
    M = floor(D);              % Parte intera M del ritardo
    alpha = D - M;             % Parte variabile alpha del ritardo
    buffer = [x(n); buffer(1:LB-1)];
    
    % ------ Interpolazione Lineare ----------------------
    y(n) = buffer(M+1)*alpha + buffer(M)*(1 - alpha);   % Eq. (6.6)
end

% Flanger/Vibrato
y = K*x + g*y;           % Eq. (6.5) con l'aggiunta di K
soundsc(y, Fs);
