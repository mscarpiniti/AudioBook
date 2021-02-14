% Implementazione dell'equalizzatore di Regalia-Mitra del I e del II
% ordine. 
% Lo script genera i due segnali filtrati e disegna le risposte in
% frequenza.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


%%
[x, Fs] = audioread('audio.wav');
ft = 2500;
f0 = 2000;
fb = 500;
G = 2;

%%
y = Eq_RM_Iord(x, Fs, ft, G);
soundsc(y, Fs);
pause;

%%
y = Eq_RM_IIord(x, Fs, f0, fb, G);
soundsc(y, Fs);




function y = Eq_RM_Iord(x, Fs, ft, G)
% Equalizzatore di Regalia-Mitra del I ordine

k = (tan(pi*ft/Fs) - 1)/(tan(pi*ft/Fs) + 1);
r = filter([-k -1], [1 k], x);
y = 0.5*(1 + G)*x + 0.5*(1 - G)*r;

alpha = 0.5*(1 + G);
beta  = 0.5*(1 - G);
b = [alpha - beta*k, alpha*k - beta];
a = [1, k];
figure
freqz(b, a);
title('Equalizzatore di Regalia-Mitra del I ordine');
end




function y = Eq_RM_IIord(x, Fs, f0, fb, G)
% Equalizzatore di Regalia-Mitra del II ordine

k1 = (1 - tan(pi*fb/Fs))/(1 + tan(pi*fb/Fs));
k2 = -cos(2*pi*f0/Fs);
r = filter([k1 k2*(1+k1) 1], [1 k2*(1+k1) k1], x);
y = 0.5*(1 + G)*x + 0.5*(1 - G)*r;

alpha = 0.5*(1 + G);
beta  = 0.5*(1 - G);
b = [alpha + beta*k1, k2*(1 + k1)*(alpha + beta), alpha*k1 + beta];
a = [1, k2*(1 + k1), k1];
figure;
freqz(b, a);
title('Equalizzatore di Regalia-Mitra del II ordine');
end
