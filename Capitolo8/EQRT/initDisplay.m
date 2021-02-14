function figWindow = initDisplay(deviceWriter, fileReader, H, Fs)

% Tale funzione crea ed inizializza l'interfaccia grafica dell'equalizzatore 
% parametrico in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Si crea la finestra.
figWindow = figure(1); clf;
set(gcf, 'Name', 'Equalizzatore parametrico in real-time (EQRT)');
set(gcf, 'NumberTitle', 'off', 'MenuBar', 'none');

% Si determina l'asse delle frequenze.
M = 1024;
f = Fs*(0:M-1)/(2*M);

% Si disegna il modulo dello spettro.
subplot(2, 1, 1);
hPlot = semilogx(f, 20*log10(H), 'LineWidth', 1.5);
xlabel('Frequenza [Hz]');
ylabel('Ampiezza [dB]');
title('Risposta Equalizzatore');
axis([0 Fs/2 -31 31]);
xticks([20 50 100 300 500 1000 3000 5000 10000 20000]);
xticklabels({'20','50','100','300','500','1k','3k','5k','10k','20k'});
grid on;

% Si aggiungono gli slider
pnl = uipanel(figWindow, 'Position', [0.05 0.05 0.9 0.4]);
S1 = uicontrol(pnl, 'Style', 'slider', 'Position', [60 40 20 120], ...
    'String', '31.5', 'Min', -30, 'Max', 30, 'Value', 0);
S2 = uicontrol(pnl, 'Style', 'slider', 'Position', [105 40 20 120], ...
    'String', '31.5', 'Min', -30, 'Max', 30, 'Value', 0);
S3 = uicontrol(pnl, 'Style', 'slider', 'Position', [150 40 20 120], ...
    'String', '31.5', 'Min', -30, 'Max', 30, 'Value', 0);
S4 = uicontrol(pnl, 'Style', 'slider', 'Position', [195 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);
S5 = uicontrol(pnl, 'Style', 'slider', 'Position', [240 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);
S6 = uicontrol(pnl, 'Style', 'slider', 'Position', [285 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);
S7 = uicontrol(pnl, 'Style', 'slider', 'Position', [330 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);
S8 = uicontrol(pnl, 'Style', 'slider', 'Position', [375 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);
S9 = uicontrol(pnl, 'Style', 'slider', 'Position', [420 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);
S10 = uicontrol(pnl, 'Style', 'slider', 'Position', [465 40 20 120], ...
    'String', 31.5, 'Min', -30, 'Max', 30, 'Value', 0);

% Si aggiunge il testo laterale
TV1 = uicontrol(pnl, 'Style', 'text', 'Position', [13 140 40 20], ...
    'String', '+30 dB');
TV2 = uicontrol(pnl, 'Style', 'text', 'Position', [13 85 40 20], ...
    'String', '0 dB');
TV3 = uicontrol(pnl, 'Style', 'text', 'Position', [13 30 40 20], ...
    'String', '-30 dB');

% Si aggiunge il testo sotto gli slider
TH1 = uicontrol(pnl, 'Style', 'text', 'Position', [54 12 30 20], ...
    'String', '31.5');
TH2 = uicontrol(pnl, 'Style', 'text', 'Position', [99 12 30 20], ...
    'String', '63');
TH3 = uicontrol(pnl, 'Style', 'text', 'Position', [144 12 30 20], ...
    'String', '125');
TH4 = uicontrol(pnl, 'Style', 'text', 'Position', [190 12 30 20], ...
    'String', '250');
TH5 = uicontrol(pnl, 'Style', 'text', 'Position', [235 12 30 20], ...
    'String', '500');
TH6 = uicontrol(pnl, 'Style', 'text', 'Position', [281 12 30 20], ...
    'String', '1000');
TH7 = uicontrol(pnl, 'Style', 'text', 'Position', [326 12 30 20], ...
    'String', '2000');
TH8 = uicontrol(pnl, 'Style', 'text', 'Position', [371 12 30 20], ...
    'String', '4000');
TH9 = uicontrol(pnl, 'Style', 'text', 'Position', [416 12 30 20], ...
    'String', '8000');
TH10 = uicontrol(pnl, 'Style', 'text', 'Position', [458 12 34 20], ...
    'String', '16000');

% Si crea un bottone di start/stop.
uiButton = uicontrol('Style', 'pushbutton', ...
   'Units', 'normalized', ...
   'Position', [0.0150 0.0111 0.1 0.0556], ...
   'Value', 1, 'String', 'Stop', ...
   'Callback', @(uiButton,event) stopSoundCard(figWindow));

% Si memorizzano tutte le variabili delle figure in un campo dati.
figData.figureWindow = figWindow;
figData.hPlot        = hPlot;
figData.uiButton     = uiButton;
figData.S1           = S1;
figData.S2           = S2;
figData.S3           = S3;
figData.S4           = S4;
figData.S5           = S5;
figData.S6           = S6;
figData.S7           = S7;
figData.S8           = S8;
figData.S9           = S9;
figData.S10          = S10;
figData.deviceReader = deviceWriter;
figData.fileReader   = fileReader;
figWindow.UserData   = figData;
