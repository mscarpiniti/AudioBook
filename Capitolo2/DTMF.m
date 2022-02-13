% Esempio di generazione di toni DTMF per la telefonia.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Parametri
T = 0.25;
Fs = 8000;
t = 0:1/Fs:T;

% Frequenze DTMF
f1 = [697, 770, 852, 941];
f2 = [1209, 1336, 1477, 1633];

% Generazione dei toni DTMF
x0 = cos(2*pi*f1(4)*t) + cos(2*pi*f2(2)*t);  % Cifra 0
x1 = cos(2*pi*f1(1)*t) + cos(2*pi*f2(1)*t);  % Cifra 1
x2 = cos(2*pi*f1(1)*t) + cos(2*pi*f2(2)*t);  % Cifra 2
x3 = cos(2*pi*f1(1)*t) + cos(2*pi*f2(3)*t);  % Cifra 3
x4 = cos(2*pi*f1(2)*t) + cos(2*pi*f2(1)*t);  % Cifra 4
x5 = cos(2*pi*f1(2)*t) + cos(2*pi*f2(2)*t);  % Cifra 5
x6 = cos(2*pi*f1(2)*t) + cos(2*pi*f2(3)*t);  % Cifra 6
x7 = cos(2*pi*f1(3)*t) + cos(2*pi*f2(1)*t);  % Cifra 7
x8 = cos(2*pi*f1(3)*t) + cos(2*pi*f2(2)*t);  % Cifra 8
x9 = cos(2*pi*f1(3)*t) + cos(2*pi*f2(3)*t);  % Cifra 9
pp = cos(2*pi*0*t);                          % Pausa

% Composizione del numero
x = [x5, pp, x5, pp, x5, pp, ...
    x9, pp, x1, pp, x8, pp, x0, pp, x2, pp, x6, pp, x4];

% Suonare il numero
soundsc(x, Fs);
