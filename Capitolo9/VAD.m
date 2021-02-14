% Esempio di implementazione di un VAD, ovvero il voice activity detector
% che stabilisce se in un frame c'è elevata probabilità che sia presente
% una voce.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

fileReader = dsp.AudioFileReader('Counting-16-44p1-mono-15secs.wav');
Fs = fileReader.SampleRate;
fileReader.SamplesPerFrame = ceil(10e-3*Fs);  % Finestre di 10 ms
deviceWriter = audioDeviceWriter('SampleRate', Fs);
VAD = voiceActivityDetector;

scope = dsp.TimeScope( ...
    'NumInputPorts', 2, ...
    'SampleRate', Fs, ...
    'TimeSpan', 3, ...
    'BufferLength', 3*Fs, ...
    'YLimits', [-1.5 1.5], ...
    'TimeSpanOverrunAction', 'Scroll', ...
    'ShowLegend', true, ...
    'ChannelNames', {'Audio', 'Probabilità del parlato'});

while ~isDone(fileReader)
    x = fileReader();
    prob = VAD(x);
    scope(x, prob*ones(fileReader.SamplesPerFrame, 1));
    deviceWriter(x);
end
