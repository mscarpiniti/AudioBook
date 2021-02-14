% File principale del misuratore di livello sonoro contenete la definizione
% delle variabili fondamentali e l'audio loop.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Scelta della costante di tempo.
% 'fast' = ~125 ms, 'slow' = ~1.0 s
% responseType = 'slow';
responseType = 'fast';

% Costante di calibrazione.
% Nota: ambienti silenziosi sono caratterizzati da circa 30 dBA.
C = 50;

% Frequenza di campionamento
% Valori tipici: {8.000, 11.025, 22.050, 44.100} kHz
Fs = 44100;

global RUNNING    % Variabile globale per fermare l'acquisizione

% Inizializzazione dei parametri e dell'interfaccia.
RUNNING = 1;
[deviceReader, N] = initSoundCard(Fs, responseType);
x = zeros(N, 1);
X = zeros(N/2, 1);
dBA = 20.0;
figWindow = initDisplay(deviceReader, x, X, dBA, Fs, C);

while (RUNNING)
    x = deviceReader();
	[X, LdBA] = stimaLivello(x, Fs, C);
    updateDisplay(figWindow, x, X, LdBA);
end
