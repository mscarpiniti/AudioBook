% Esempio di controllo del guadagno audio in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

Fs = 44100;

% Creazione oggetti audio
deviceReader = audioDeviceReader;
setup(deviceReader);
deviceWriter = audioDeviceWriter;
scope = dsp.TimeScope('SampleRate', 44100, ...
         'TimeSpan', 16, 'BufferLength', 1.5e6, 'YLimits', [-1, 1]);

% Creazione oggetto parametri
g = parametri;
g.nome = 'Gain';
g.valore = 1.0;

% Apertura interfaccia grafica
controllaParametro(g, 0, 5);

% Audio Stream Loop
tic;
while toc < 10
    audioIn = deviceReader();
	drawnow limitrate
	audioOut = audioIn .* g.valore;
    scope(audioOut);
    deviceWriter(audioOut);
end

% Rilascio delle risorse
release(deviceReader);
release(deviceWriter);
release(scope);