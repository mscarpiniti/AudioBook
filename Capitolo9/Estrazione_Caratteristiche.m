% Esempio di implementazione dell'estrazione di diverse caratteristiche
% da un segnale audio.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

aFE = audioFeatureExtractor( ...
    'SampleRate', Fs, ...
    'Window', hamming(round(0.03*Fs), 'periodic'), ...
    'OverlapLength', round(0.02*Fs), ...
    'mfcc', true, ...
    'mfccDelta', true, ...
    'mfccDeltaDelta', true, ...
    'pitch', true, ...
    'spectralCentroid', true);

features = extract(aFE, x);