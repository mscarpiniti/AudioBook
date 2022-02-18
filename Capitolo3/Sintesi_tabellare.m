% Esempio di generazione di un tono sinusoidale attraverso la sintesi 
% tabellare.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

Lt = 4096;    % Lunghezza della tabella
Fs = 8000;    % Frequenza di campionamento
fd = 100;     % Frequenza desiderata
T  = 4;       % Secondi da generare

tabella = sin(2*pi*(0:Lt-1)/Lt);  % Si riempe la tabella

incr = fd * Lt/Fs;    % Calcolo dell'incremento con la (3.1)

% Inizializzazioni
Ly = T*Fs;            % Lunghezza del segnale da generare
y = zeros(Ly, 1);     % Inizializzazione del segnale
fase = 1;             % Fase iniziale

% Generazione dei campioni
for k = 1:Ly
    y(k) = tabella(fase);        % Lettura della tabella
    fase = round(fase + incr);   % Incremento della fase
    if fase > Lt
        fase = fase - Lt;
    end
end

% Grafico dei primi 250 campioni generati
figure;
plot(y(1:250));
grid on
title('Segnale generato');
xlabel('Indice \itn');
ylabel('Ampiezza');

% Ascolto del risultato
soundsc(y, Fs);
