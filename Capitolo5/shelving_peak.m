% Implementazione di un filtro shelving del secondo ordine di tipo 
% peak/notch.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

function y = shelving_peak(x, f0, fb, G, Fs)
% Filtro shelving del secondo ordine di tipo peak/notch.
% f0 è la frequenza del picco, fb è larghezza del picco, G il guadagno in dB

V0 = 10^(G/20);
H0 = V0 - 1;
k = tan(pi*fb/Fs);
d = -cos(2*pi*f0/Fs);
if G>= 0
    a = (k - 1)/(k + 1);     % Boost (Peak)
else
    a = (k - V0)/(Vk + V0);  % Cut (Notch)
end

xh = [0, 0];
y = zeros(size(x));
for n = 1:length(x)
    xh_new = x(n) - d*(1 - a)*xh(1) + a*xh(2);
    y1 = -a*xh_new + d*(1 - a)*xh(1) + xh(2);
    xh = [xh_new, xh(1)];
    y(n) = 0.5*H0*(x(n) - y1) + x(n);  % Peak/Notch
end
