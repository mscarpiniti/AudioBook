function SIR = evalSIR2(Q)
% Valuta l'indice SIR per ogni sorgente separata.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

SIR = 10*log10( max(Q.^2)./(diag(Q.'*Q).' - max(Q.^2)) );