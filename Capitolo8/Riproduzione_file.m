% Esempio di riproduzione di un file audio in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

NomeFile = 'audio.wav';      % File di esempio da riprodurre
fileReader = dsp.AudioFileReader(NomeFile);
fileInfo = audioinfo(NomeFile);
deviceWriter = audioDeviceWriter('SampleRate', fileInfo.SampleRate);
setup(deviceWriter, zeros(fileReader.SamplesPerFrame, fileInfo.NumChannels));

% Main loop
while ~isDone(fileReader)
    audioData = fileReader();
    deviceWriter(audioData);
end

% Rlascio delle risorse
release(fileReader);
release(deviceWriter);