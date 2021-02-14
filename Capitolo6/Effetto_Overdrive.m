% Esempio di implementazione dell'effetto overdrive.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');
x = 1.5*x/max(x);     % Si rende x a piena dinamica
alpha = 0.5;
xd = zeros(size(x));
y = zeros(size(x));

for n=1:length(x)
    xM = abs(x(n));
    if xM <= 1/3
        xd(n) = 2*x(n);
    elseif ((xM > 1/3) && (xM < 2/3))
        xd(n) = sign(x(n))*(3 - (2 - 3*xM)^2)/3;
    else
        xd(n) = sign(x(n));
    end
    y(n) = (1 - alpha)*x(n) + alpha*xd(n);  % Wet & dry, Eq. (6.8)
end

soundsc(y, Fs);