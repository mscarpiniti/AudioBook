% Esempio di implementazione dell'estrazione delle caratteristiche
% cepstrali da un segnale audio.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


[x, Fs] = audioread('SpeechDFT-16-8-mono-5secs.wav');

durata = round(0.04*Fs);    % 40 ms
s = x(5500:5500+durata-1);  % Segmento di 40 ms a partire dal campione 5500

cepstrum = cepstralFeatureExtractor('SampleRate', Fs);
[coefficienti, delta, deltaDelta] = cepstrum(s);
disp(coefficienti)
