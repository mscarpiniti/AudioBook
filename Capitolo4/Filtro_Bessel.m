% Esempio di filtro di Bessel analogico.
%
% M. Scarpiniti (Dip. DIET - Sapienza UniversitÓ di Roma)

N = 5;
wt = 10000;
[b, a] = besself(N, wt);
freqs(b, a);