function [b, a] = peak(f0, fb, G, Fs)
% Funzione che implementa il filtro shelving del secondo ordine di tipo 
% peak/notch. Il filtro è utilizzato in modalità boost se il guadagno in
% dB è positivo, altrimenti è utilizzato in modalità cut.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

k = tan(pi*f0/Fs);
Q = f0/fb;
V0 = 10^(G/20);

if G >= 0  % Peak (boost)
    den = 1 + 1/Q*k + k^2;
    b0 = (1 + V0/Q*k + k^2)/den;
    b1 = 2*(k^2 - 1)/den;
    b2 = (1 - V0/Q*k + k^2)/den;
    a1 = 2*(k^2 - 1)/den;
    a2 = (1 - 1/Q*k + k^2)/den;
else       % Notch (cut)
    den = 1 + 1/(Q*V0)*k + k^2;
    b0 = (1 + 1/Q*k + k^2)/den;
    b1 = 2*(k^2 - 1)/den;
    b2 = (1 - 1/Q*k + k^2)/den;
    a1 = 2*(k^2 - 1)/den;
    a2 = (1 - 1/(Q*V0)*k + k^2)/den;
end

b = [b0, b1, b2];
a = [ 1, a1, a2];