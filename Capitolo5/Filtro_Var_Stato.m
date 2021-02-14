% Implementazione del filtro a variabile di stato, che consente di ottenere
% l'uscita passa-basso, passa-banda e passa-alto.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


[x, Fs] = audioread('audio.wav');

f0 = 5000;
fb = 4000;
Q = f0/fb;
F1 = 2*sin(pi*f0/Fs);
Q1 = 1/Q;
yl = zeros(size(x));
yb = zeros(size(x));
yh = zeros(size(x));

% Loop principale
for n = 2:length(x)
    yh(n) = x(n) - yl(n-1) - Q1*yb(n-1);
    yb(n) = F1*yh(n) + yb(n-1);
    yl(n) = F1*yb(n) + yl(n-1);
end

% Grafico dei tre segnali audio
figure;
plot((0:length(x)-1)/Fs, [yl yb yh]);
title('Uscite del filtro a variabile di stato');
xlabel('Tempo (s)');
ylabel('Ampiezza');
legend('Passa basso','Passa banda','Passa alto');

soundsc(yl + yb + yh, Fs);