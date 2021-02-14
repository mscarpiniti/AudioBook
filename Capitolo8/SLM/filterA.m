function A = filterA(f)
% Tale funzione determina la maschera del filtro di pesatura A.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

c1 = 3.5041384e16;
c2 = 20.598997^2;
c3 = 107.65265^2;
c4 = 737.86223^2;
c5 = 12194.217^2;
f(f == 0) = 1e-17;    % Eliminazione degli zeri
f = f.^2;
num = c1*f.^4;
den = ((c2 + f).^2) .* (c3 + f) .* (c4 + f) .* ((c5 + f).^2);
A = num./den;