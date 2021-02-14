function [X, LdBA] = stimaLivello(x, Fs, C)
% Tale funzione determina il livello sonoro con pesatura A (in dBA) di una
% finestra di segnale e il relativo spettro.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

X = abs(fft(x));
X(X == 0) = 1e-17;
f = (Fs/length(X))*(0:(length(X)-1));
ind = find(f<Fs/2);
f = f(ind);
X = X(ind);
A = filterA(f);
X = A'.*X;
EnergiaTotale = sum(X.^2)/length(X);
EnergiaMedia = EnergiaTotale/((1/Fs)*length(x));
LdBA = 10*log10(EnergiaMedia) + C;
X = 20*log10(X);
