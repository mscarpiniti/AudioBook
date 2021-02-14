% Esempio di un filtro all-pass implementato con la tecnica del buffer
% circolare con un solo puntatore
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');
g = 0.7;        % Guadagno
T = 0.1;        % Ritardo
D = Fs*T;       % Ritardo in campioni
LB = round(D);  % Lunghezza del buffer
buffer = zeros(LB, 1); % Inizializzazione del buffer
y = zeros(size(x));    % Inizializzazione del segnale di uscita
pt = 1;         % Valore iniziale del puntatore

for n = 1:length(x)
    temp = buffer(pt);           % Passo 1)
    buffer(pt) = x(n) - g*temp;  % Passo 2)
    y(n) = temp + g*x(n);        % Passo 3)
    pt = pt + 1;      % Incremento del puntatore
    if (pt > LB)      % Se il buffer è finito 
        pt = 1;       % si ricomincia da capo
    end
end