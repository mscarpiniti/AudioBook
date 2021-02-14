% Esempio di controllo del guadagno audio in tempo reale, attraverso l'uso
% di un controller MIDI.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Identificazione del dispositivo MIDI e relativo controllo
[numeroControllo, nomeDispositivo] = midiid;
valoreIniziale = 1;
midi_listener = midicontrols(numeroControllo, valoreIniziale, 'MIDIDevice', nomeDispositivo);

% Apertura del file audio e dispositivo di riproduzione
fileReader = dsp.AudioFileReader('RockDrums-44p1-stereo-11secs.mp3');
deviceWriter = audioDeviceWriter('SampleRate', fileReader.SampleRate);

% Main audio loop
while ~isDone(fileReader)
    audioData = step(fileReader);  
    valoreControllo = midiread(midi_listener);   % SI legge il valore del controllo 
    G = 2*valoreControllo;
    audioDataOut = G*audioData;    
    deviceWriter(audioDataOut);
end

% Si rilasciano tutte le risorse
release(fileReader);
release(deviceWriter);