function [b, a] = creaFiltri(G, Fs)

% Tale funzione genera i coefficienti di tutti i filtri dell'equalizzatore 
% parametrico in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Insieme delle frequenze
f0 = [31.5 63 125 250 500 1000 2000 4000 8000 16000];
f1 = [22 44  88 177 355  710 1420 2840  5680 11360];
f2 = [44 88 177 355 710 1420 2840 5680 11360 22000];

NB = length(f0);  % Numero di bande
b = cell(1, NB);
a = cell(1, NB);

% Primo filtro di tipo passa-basso
[b{1}, a{1}] = passa_basso(f0(1), G(1), Fs);

% NB-2 filtri di tipo passa-banda
for k = 2:NB-1
    [b{k}, a{k}] = peak(f0(k), f2(k) - f1(k), G(k), Fs);
end

% Ultimo filtro di tipo passa-alto
[b{end}, a{end}] = passa_alto(f0(end), G(end), Fs);
