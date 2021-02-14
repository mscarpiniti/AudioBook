% Esempio di un banco filtri diadico a 2 livelli asimmetrico con tre 
% sotto-bande applicate a un'onda quadra rumorosa.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

t = 0:.0001:.0511;
x = square(2*pi*30*t);
xn = x' + 0.08*randn(length(x), 1);  % Segnale rumoroso

bDA = dsp.DyadicAnalysisFilterBank;
bDA.CustomLowpassFilter = [1/sqrt(2) 1/sqrt(2)];
bDA.CustomHighpassFilter = [-1/sqrt(2) 1/sqrt(2)];
bDS = dsp.DyadicSynthesisFilterBank;
bDS.CustomLowpassFilter = [1/sqrt(2) 1/sqrt(2)];
bDS.CustomHighpassFilter = [1/sqrt(2) -1/sqrt(2)];

xb = bDA(xn);         % Analisi
x1 = xb(1:256);       % Prima sotto-banda
x2 = xb(257:384);     % Seconda sotto-banda
x3 = xb(385:512);     % Terza sotto-banda
yb = [zeros(length(x1), 1); zeros(length(x2), 1); x3];
y = bDS(yb);          % Sintesi

subplot(2, 1, 1);
plot(xn);
xlim([1, 512]);
title('Segnale originale rumoroso');
xlabel('n')
ylabel('x[n]')

subplot(2, 1, 2);
plot(y);
xlim([1, 512]);
title('Segnale ripulito');
xlabel('n')
ylabel('y[n]')
