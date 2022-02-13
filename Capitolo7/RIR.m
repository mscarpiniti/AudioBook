% Esempio di utilizzo di RIR Generator (dell'Audio Labs dell'Università di
% Erlangen).
%
% M. Scarpiniti  --  DIET Department, Sapienza University


% Scelta dei parametri ----------------------------------------------------
c = 340;                   % Velocità del suono (m/s)
Fs = 44100;                % Frequenza di campionamento (Hz)
r = [2 1.5 2];             % Posizione del ricevitore (m)
s = [2 3.5 2];             % Posizione della sorgente (m)
L = [5 4   6];             % Dimensioni della stanza (m)
T60 = 0.75;                 % Tempo di riverberazione (s)
N = 8192;                  % Numero di campioni
mtype = 'hypercardioid';   % Type of microphone
order = -1;                % Massimo ordine di riflessione
dim = 3;                   % Dimensioni della stanza
orientation = [pi/2 0];    % Orientazione del microfono (rad)
hp_filter = 1;             % Abilita il filtro passa-alto

% Generazione RIR ---------------------------------------------------------
h = rir_generator(c, Fs, r, s, L, T60, N, mtype, order, dim, ...
    orientation, hp_filter);

% Grafico della RIR -------------------------------------------------------
% Grafico in campioni
figure;
plot(h);
title('Risposta impulsiva della stanza');
xlabel('Campione [{\itn}]');
ylabel('Ampiezza');

% Grafico in tempo
figure;
t = (0:N-1)/Fs;
plot(t, h);
title('Risposta impulsiva della stanza');
xlabel('Tempo [{\its}]');
ylabel('Ampiezza');
