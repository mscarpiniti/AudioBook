% Implementazione di un secondo algoritmo per la rimozione dei click.
% La rimozione avviene sostituendo i valori anomali con il valore predetto
% dalla predizione lineare.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Svuoto lo schermo e la memoria.
clear all
close all
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scelta dei parametri.
M = 50;        % ordine del predittore lineare
cost = 2500;  % costante che consente di stimare il livello dei click

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carico un segnale con i click.
[x, Fs] = audioread('radioclick.wav');
t = (1:length(x))/Fs;
soundsc(x, Fs);
plot(t, x);
xlabel('Tempo');
ylabel('Ampiezza');
title('Audio con Click');
disp('>> Premi un tasto per continuare....');
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo principale.
E = sum(x.^2);              % Energia di tutto il segnale
soglia = E/cost;
id = find(x.^2 > soglia);   % Vedo i campioni che hanno elevata energia
for k = 1:length(id)
    xp = x(id(k)-M:id(k)-1);
    a = lpc(xp);
    x(id(k)) = [0 -a(2:end)]*xp;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualizzo e ascolto il risultato.
soundsc(x, Fs);
figure;
plot(t, x);
xlabel('Tempo');
ylabel('Ampiezza');
title('Audio Ripulito');
