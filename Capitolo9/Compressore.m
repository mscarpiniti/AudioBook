% Esempio di implementazione di un compressore che agisce sul segnale 
% letto in tempo reale da un file.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Impostazione dei parametri
L = 1024;     % Lunghezza del frame
S = -15;      % Soglia del compressore in dB
R = 7;        % Rapporto di compressione
Ta = 0.04;    % Tempo di attacco

% Creazione degli oggetti
fileReader = dsp.AudioFileReader('Filename', 'RockDrums-44p1-stereo-11secs.mp3',...
    'SamplesPerFrame', L);
deviceWriter = audioDeviceWriter('SampleRate', fileReader.SampleRate);
comp = compressor('Threshold', S, 'Ratio', R, ...
    'SampleRate', fileReader.SampleRate, 'AttackTime', Ta);
visualize(comp);

% Stream loop
while ~isDone(fileReader)
    x = fileReader();    % Lettura del file
    [y, g] = comp(x);    % Compressione
    deviceWriter(y);     % Ascolto
end

% Rilascio delle risorse
release(comp);
release(deviceWriter);