% Esempio di riproduzione/registrazione di un file audio in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

fileReader = dsp.AudioFileReader('Counting-16-44p1-mono-15secs.wav', 'SamplesPerFrame',256);
Fs = fileReader.SampleRate;
fileWriter = dsp.AudioFileWriter('Counting-PlaybackRecorded.wav','SampleRate',Fs);
playRec = audioPlayerRecorder('SampleRate', Fs);

% Main loop
while ~isDone(fileReader)
    playData = fileReader();
    [recData, nUnderruns, nOverruns] = playRec(playData);
    fileWriter(recData);

    if nUnderruns > 0
        fprintf('La coda di lettura è bloccata da %d campioni.\n', nUnderruns);
    end
    if nOverruns > 0
       fprintf('La coda di scrittura è sovrascritta di %d campioni.\n', nOverruns);
    end
end

% Rilascio delle risorse
release(fileReader);
release(fileWriter);
release(playRec);