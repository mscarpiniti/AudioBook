% File principale dell'equalizzatore parametrico in tempo reale contenente 
% la definizione delle variabili fondamentali e l'audio loop.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


global RUNNING    % Variabile globale per fermare l'acquisizione

% Inizializzazione dei parametri e dell'interfaccia.
RUNNING = 1;
NB = 10;    % Numero di bande
M  = 1024;  % Numero di punti in frequenza

% Lettura del file
NomeFile = 'audio.wav';      % File di esempio da riprodurre
fileReader = dsp.AudioFileReader(NomeFile, 'PlayCount', 5);
fileInfo = audioinfo(NomeFile);
Fs = fileInfo.SampleRate;

% Impostazione della scheda audio
deviceWriter = audioDeviceWriter('SampleRate', Fs);
setup(deviceWriter, zeros(fileReader.SamplesPerFrame, fileInfo.NumChannels));

% Creazione dell'interfaccia
H = ones(M, 1);
figWindow = initDisplay(deviceWriter, fileReader, H, Fs);

% Lettura degli slider
G = slideReader(figWindow);

% Crezione dei filtri
[b, a] = creaFiltri(G, Fs);
zi = cell(1, NB);
for k = 1:NB
    zi{k} = zeros(1, 2);  % Condizioni iniziali
end


while (RUNNING)
    audioData = fileReader();
    G = slideReader(figWindow);
    H = ones(M, 1);
    y = audioData;
    [b, a] = creaFiltri(G, Fs);
    
    for k = 1:NB
        H = H.*abs(freqz(b{k}, a{k}, M));
        [y, zi{k}] = filter(b{k}, a{k}, y, zi{k}); 
    end
    
    deviceWriter(y);
    updateDisplay(figWindow, H);
end
