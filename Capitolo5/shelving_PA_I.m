% Implementazione di un filtro shelving passa-alto del primo ordine.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

function y = shelving_PA_I(x, ft, G, Fs)
% Filtro shelving passa-alto del primo ordine.
% ft è la frequenza di taglio, G il guadagno in dB.

V0 = 10^(G/20);
H0 = V0 - 1;
k = tan(pi*ft/Fs);
if G>= 0
    a = (k - 1)/(k + 1);        % Boost
else
    a = (V0*k - 1)/(V0*k + 1);  % Cut
end

xh = 0;
y = zeros(size(x));
for n = 1:length(x)
    xh_new = x(n) - a*xh;
    y1 = a*xh_new + xh;
    xh = xh_new;
    y(n) = 0.5*H0*(x(n) - y1) + x(n);  % PA
end
