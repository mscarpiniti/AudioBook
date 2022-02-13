% Esempio di generazione di un tono sinusoidale attraverso la sintesi 
% tabellare.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

Lt = 4096;    % Lunghezza della tabella
Fs = 8000;    % Frequenza di campionamento
fd = 100;     % Frequenza desiderata
T  = 4;       % Secondi da generare

tabella = sin(2*pi*(0:Lt-1)/Lt);  % Si riempe la tabella

incr = fd * Lt/Fs;    % Calcolo dell'incremento con la (2.1)

% Inizializzazioni
Ly = T*Fs;
y = zeros(Ly, 1);
ind = 1;

% Generazione dei campioni
for k = 1:Ly
    y(k) = tabella(ind);
    ind = round(ind + incr);
    if ind > Lt
        ind = ind - Lt;
    end
end

% Grafico dei primi 250 campioni generati
figure;
plot(y(1:250));
grid on
title('Segnale generato');
xlabel('Indice \itn');
ylabel('Ampiezza');

soundsc(y, Fs);   % Ascolto del risultato
