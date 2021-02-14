function PI = evalPI(Q)
% Valuta l'indice che misura la vicinanza al modello inverso (Amari
% Performance Index PI).
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

N = size(Q, 1);
QP = abs(Q);
% QP = abs(Q.^2);  % Versione alternativa 
PI1 = sum(QP, 1)./max(QP, [], 1);
PI2 = sum(QP, 2)./max(QP, [], 2);
PI = (sum(PI1) + sum(PI2) - 2*N)/(N*(N-1));
