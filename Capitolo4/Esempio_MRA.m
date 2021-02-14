% Esempio di un analisi a multi-risoluzione utilizzando la decomposizione
% wavelet a massima sovrapposizione (MODWT).
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

v = 0:0.00614:2*pi;
x = sin(v) + 0.3*rand(1, numel(v));
L = 5;

w = modwt(x, 'db5', L);
mra = modwtmra(w, 'db5');

figure;
n = 1:1024;
subplot(7, 1, 1);
plot(n, x);
title('Analisi a multi-risoluzione')
xlim([0 1024]);
for k = 2:7
    subplot(7, 1, k);
    plot(n, mra(k-1, :));
    xlim([0 1024]);
end
