function [b, a] = passa_alto(ft, G, Fs)
% Funzione che implementa il filtro shelving del secondo ordine di tipo 
% passa-alto. Il filtro è utilizzato in modalità boost se il guadagno in
% dB è positivo, altrimenti è utilizzato in modalità cut.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

k = tan(pi*ft/Fs);
V0 = 10^(G/20);

if G >= 0   % Boost
    den = 1 + sqrt(2)*k + k^2;
    b0 = (V0 + sqrt(2*V0)*k + k^2)/den;
    b1 = 2*(k^2 - V0)/den;
    b2 = (V0 - sqrt(2*V0)*k + k^2)/den;
    a1 = 2*(k^2 - 1)/den;
    a2 = (1 - sqrt(2)*k + k^2)/den;
else        % Cut
    den = 1 + sqrt(2*V0)*k + V0*k^2;
    b0 = V0*(1 + sqrt(2)*k + k^2)/den;
    b1 = 2*V0*(k^2 - 1)/den;
    b2 = V0*(1 - sqrt(2)*k + k^2)/den;
    a1 = 2*(V0*k^2 - 1)/den;
    a2 = (1 - sqrt(2*V0)*k + V0*k^2)/den;
end

b = [b0, b1, b2];
a = [ 1, a1, a2];
