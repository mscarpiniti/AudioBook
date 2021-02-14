function [deviceReader, N] = initSoundCard(Fs, responseType)
% Tale funzione inizializza la scheda audio impostandone i valori.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

if strcmp(responseType, 'slow')
   durata = 1.0;
else
   durata = 0.125;
end
durata = durata/4;
N = ceil(durata*Fs);
N = 2^nextpow2(N);

deviceReader = audioDeviceReader('SampleRate', Fs, 'SamplesPerFrame', N);