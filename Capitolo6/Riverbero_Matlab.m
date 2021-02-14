% Esempio di implementazione di un algoritmo per la riverberazione che
% utilizza filtri comb.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Creazione dell'oggetto
rev = reverberator;
% rev = reverberator('Diffusion', 0.75, 'DecayFactor', 0.3, 'WetDryMix', 0.6);

% Utilizzo dell'oggetto
y = rev(x);

% Ascolto del risultato
soundsc(y, Fs);
