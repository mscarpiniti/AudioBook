% Esempio di un banco filtri con due sotto-bande applicate a un segnale di
% rumore Gaussiano.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


lpcA = [-0.0106, 0.0329, 0.0308, -0.1870, -0.0280, 0.6309, 0.7148, 0.2304];
hpcA = [-0.2304, 0.7148, -0.6309, -0.0280, 0.1870, 0.0308, -0.0329, -0.0106];
lpcS = [0.2304, 0.7148, 0.6309, -0.0280, -0.1870, 0.0308, 0.0329, -0.0106];
hpcS = [-0.0106, -0.0329, 0.0308, 0.1870, -0.0280, -0.6309, 0.7148, -0.2304];
bA = dsp.SubbandAnalysisFilter(lpcA, hpcA);
bS = dsp.SubbandSynthesisFilter(lpcS, hpcS);

x = randn(256, 1);
[xh, xl] = bA(x);
yh = 0.5*xh;
yl = xl;
y = bS(yh, yl);

subplot(2, 1, 1);
plot(x);
xlim([1, 256]);
title('Segnale originale')
xlabel('n')
ylabel('x[n]')

subplot(2, 1, 2);
plot(y)
xlim([1, 256]);
title('Segnale ricostruito')
xlabel('n')
ylabel('y[n]')
