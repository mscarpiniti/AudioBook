% Implementazione di un filtro shelving passa-basso del primo ordine.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

function y = shelving_PB_I(x, ft, G, Fs)
% Filtro shelving passa-basso del primo ordine.
% ft è la frequenza di taglio, G il guadagno in dB.

V0 = 10^(G/20);
H0 = V0 - 1;
k = tan(pi*ft/Fs);
if G>= 0
    a = (k - 1)/(k + 1);    % Boost
else
    a = (k - V0)/(k + V0);  % Cut
end

xh = 0;
y = zeros(size(x));
for n = 1:length(x)
    xh_new = x(n) - a*xh;
    y1 = a*xh_new + xh;
    xh = xh_new;
    y(n) = 0.5*H0*(x(n) + y1) + x(n);  % PB
end
