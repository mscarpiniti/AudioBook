% Esempio di generazione di una forma d'onda a gradinata con frequenza 
% variabile: ogni 1000 cicli la frequenza dell'onda viene incrementata di 
% 10 Hz, partendo da una frequenza base di f0 = 10 Hz.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

f0 = 10;
valori = -1:0.1:1;
tabella = ones(100, 1) * valori;
tabella = reshape(tabella, numel(tabella), 1);

% Oggetto per la sintesi tabellare
onda = wavetableSynthesizer(tabella, f0);

% Scope temporale
scope = dsp.TimeScope( ...
    'SampleRate', onda.SampleRate, ...
    'TimeSpan', 0.1, ...
    'YLimits', [-1.5, 1.5], ...
    'TimeSpanOverrunAction', 'Scroll', ...
    'ShowGrid', true, ...
    'Title', 'Variable-Frequency Staircase Wave');
		
% Main loop
k = 0;
while (k < 1e4)
    k = k + 1;
    gradinata = onda();
    scope(gradinata);
    if mod(k, 1000) == 0
        onda.Frequency = onda.Frequency + 10;  % Si incrementa la frequenza
    end
end
