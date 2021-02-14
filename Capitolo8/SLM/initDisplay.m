function figWindow = initDisplay(deviceReader, x, X, dBA, Fs, C)
% Tale funzione crea ed inizializza l'interfaccia grafica del misuratore di
% livello sonoro.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Si crea la finestra.
figWindow = figure(1); clf;
set(gcf, 'Name', 'Misuratore del Livello Sonoro (SLM)');
set(gcf, 'NumberTitle', 'off', 'MenuBar', 'none');

% Si determina l'asse delle frequenze.
f = (Fs/length(x))*(0:(length(X)-1));

% Si disegna il modulo dello spettro.
subplot(2, 1, 1);
fftPlot = plot(f, X);
title('Risposta in Ampiezza con pesatura A');
xlabel('Frequenza (Hz)');
ylabel('Modulo (dB)');
xlim([0 Fs/2]);
ylim([-100 60]);
grid on;

% Si disegna il segnale (nel tempo).
subplot(2, 2, 3);
samplePlot = plot((1:length(x)), x);
title('Segnale in Ingresso');
xlabel('Campioni');
ylabel('Tensione in Ingresso');
axis([0 length(x) -1 1]);
grid on;

% Si converte la stima dei dBA in una stringa.
dBA_str = sprintf('%5.1f%s', dBA, ' dBA');

% Si disegna la stima dei dBA.
subplot(2,2,4); axis off;
dBA_text = text(1.0,0.5, dBA_str, 'FontSize', 38, ...
    'HorizontalAlignment', 'Right', 'Color', 'r');

% Si crea un bottone di start/stop.
uiButton = uicontrol('Style', 'pushbutton', ...
   'Units', 'normalized', ...
   'Position', [0.0150 0.0111 0.1 0.0556], ...
   'Value', 1, 'String', 'Stop', ...
   'Callback', @(uiButton,event) stopSoundCard(figWindow));

% Si memorizzano tutte le variabili delle figure in un campo dati.
figData.figureWindow = figWindow;
figData.uiButton     = uiButton;
figData.samplePlot   = samplePlot;
figData.fftPlot      = fftPlot;
figData.dBA_text     = dBA_text;
figData.deviceReader = deviceReader;
figData.C            = C;
figWindow.UserData   = figData;
