% Esempio di implementazione di un un semplice sintetizzatore
% che genera un'onda quadra, la cui frequenza è controllata dalla 
% pressione di un tasto su un controller MIDI.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

nomeDevice = 'Keystation Mini 32';  % <== Dispositivo MIDI
device = mididevice(nomeDevice);

osc = audioOscillator('square', 'Amplitude', 0);  % Onda quadra
deviceWriter = audioDeviceWriter;
deviceWriter.SupportVariableSizeInput = true;  % Per input di lunghezza variabile
deviceWriter.BufferSize = 64;     % Piccolo per bassa latenza
tic;

while toc < 60  % Per 60 secondi
    msgs = midireceive(device);   % Riceve un messaggio
    for i = 1:numel(msgs)
        msg = msgs(i);
        if isNoteOn(msg)          % Se NOTE ON
            osc.Frequency = note2freq(msg.Note);  % Frequenza
            osc.Amplitude = msg.Velocity/127;     % Ampiezza
        elseif isNoteOff(msg)     % Se NOTE OFF
            if msg.Note == msg.Note
                osc.Amplitude = 0;
            end
        end
    end
    deviceWriter(osc());    % Suona i campioni
end

release(osc);
release(deviceWriter);



function r = isNoteOn(msg)
    r = msg.Type == midimsgtype.NoteOn && msg.Velocity > 0;
end


function r = isNoteOff(msg)
    r = msg.Type == midimsgtype.NoteOff ...
        || (msg.Type == midimsgtype.NoteOn && msg.Velocity == 0);
end


function freq = note2freq(nota)
    freqLA = 440;
    notaLA = 69;
    freq = freqLA * 2.^((nota - notaLA)/12);
end
