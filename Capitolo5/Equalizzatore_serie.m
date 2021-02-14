% Equalizzatore multibande con architettura in serie.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Insieme delle frequenze
f0 = [31.5 63 125 250 500 1000 2000 4000 8000 16000];
f1 = [22 44  88 177 355  710 1420 2840  5680 11360];
f2 = [44 88 177 355 710 1420 2840 5680 11360 22000];

% Insieme dei guadagni in dB
G = [0, 0, 0, 0, 0, -15, 0, 0, 20, 0];

NB = length(f0);  % Numero di bande
b = cell(1, NB);
a = cell(1, NB);

% Primo filtro di tipo passa-basso
[b{1}, a{1}] = passa_basso(f0(1), G(1), Fs);

% NB-2 filtri di tipo passa-banda
for k = 2:NB-1
    [b{k}, a{k}] = peak(f0(k), f2(k) - f1(k), G(k), Fs);
end

% Ultimo filtro di tipo passa-alto
[b{end}, a{end}] = passa_alto(f0(end), G(end), Fs);


% Creazione della risposta in frequenza
H = ones(1024, 1);
for k = 1:NB
    H = H.*abs(freqz(b{k}, a{k}, 1024));    % Eq. (5.41)
end
semilogx(Fs*(0:1023)/2048, 20*log10(H), 'LineWidth', 1.5);
xlabel('Frequenza [kHz]');
ylabel('Ampiezza [dB]');
title('Risposta Equalizzatore');
axis([0 Fs/2 -31 31]);
xticks([20 50 100 300 500 1000 3000 5000 10000 20000]);
xticklabels({'20','50','100','300','500','1k','3k','5k','10k','20k'})
grid on;

% Filtraggio del segnale
y = x;
for k = 1:NB
    y = filter(b{k}, a{k}, y); 
end 
soundsc(y, Fs);



function [b, a] = passa_basso(ft, G, Fs)
% Funzione che implementa il filtro shelving del secondo ordine di tipo 
% passa-basso. Il filtro è utilizzato in modalità boost se il guadagno in
% dB è positivo, altrimenti è utilizzato in modalità cut.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

k = tan(pi*ft/Fs);
V0 = 10^(G/20);

if G >= 0   % Boost
    den = 1 + sqrt(2)*k + k^2;
    b0 = (1 + sqrt(2)*k + V0*k^2)/den;
    b1 = 2*(V0*k^2 - 1)/den;
    b2 = (1 - sqrt(2)*k + V0*k^2)/den;
    a1 = 2*(k^2 - 1)/den;
    a2 = (1 - sqrt(2)*k + k^2)/den;
else        % Cut
    den = V0 + sqrt(2*V0)*k + k^2;
    b0 = V0*(1 + sqrt(2)*k + k^2)/den;
    b1 = 2*V0*(k^2 - 1)/den;
    b2 = V0*(1 - sqrt(2)*k + k^2)/den;
    a1 = 2*(k^2 - V0)/den;
    a2 = (V0 - sqrt(2*V0)*k + k^2)/den;
end

b = [b0, b1, b2];
a = [ 1, a1, a2];

end



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

end



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

end
