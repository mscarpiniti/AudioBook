% Implementazione di un algoritmo di deHum per la rimozione dei rumori
% armonici a 50 Hz.
% La rimozione avviene utilizzando un filtro notch, i cui coefficienti sono
% caricati dal file notch50.mat.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

f0 = 50;       % Frequenza del disturbo
load notch50   % I parametri di un filtro notch

[x, Fs] = audioread('radio.wav');
t = (1:length(x))/Fs;
soundsc(x, Fs);
figure;
plot(t, x);
grid on;
title('Segnale originale');
xlabel('Tempo [s]');
ylabel('Ampiezza');

n = sin(2*pi*f0*t);
xr = x + 0.5*n.';   % Segnale rumoroso
soundsc(xr, Fs);
figure;
plot(t, xr);
grid on;
title('Segnale rumoroso');
xlabel('Tempo [s]');
ylabel('Ampiezza');
figure;
freqz(b, a, 20);    % b e a sono in notch50

xp = filter(b, a, xr);  % Segnale ripulito
soundsc(xp, Fs);
figure;
plot(t, xp);
grid on;
title('Segnale ripulito');
xlabel('Tempo [s]');
ylabel('Ampiezza');
