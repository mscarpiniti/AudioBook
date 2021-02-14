% Script di esempio per l'utilizzo della classe mediaMobile che implementa
% un oggetto di sistema per gestire l'audio in tempo reale.
% In questo script, si utilizza l'oggetto di sistema mediaMobile per
% filtrare una sinusoide rumorosa.
% Si faccia attenzione che l'oggetto si aspetta un vettor (o matrice)
% organizzata per colonne.

% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

v = 0:pi/500:2*pi;
x = sin(v.') + 0.3*rand(length(v), 1);

mm = mediaMobile('WindowLength', 20);
y = mm(x);

plot(v, x, v, y);
grid on;
title('Applicazione del filtro a media mobile');
xlabel('Angolo');
ylabel('Ampiezza');
legend('Segnale originale', 'Segnale filtrato');