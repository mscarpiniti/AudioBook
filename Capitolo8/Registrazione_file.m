% Esempio di registrazione di un file audio in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

NomeFile = 'Prova.wav';    % File di esempio da registrare
deviceReader = audioDeviceReader;
setup(deviceReader);
fileWriter = dsp.AudioFileWriter(NomeFile, 'FileFormat', 'WAV');
disp('Parla ora ...');

% Main loop
tic;
while toc < 10
    audioData = deviceReader();
    fileWriter(audioData);
end
disp('Registrazione completa.');
		
% Rilascio delle risorse
release(deviceReader);
release(fileWriter);