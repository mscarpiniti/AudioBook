% Implementazione di un primo algoritmo per la rimozione dei click.
% La rimozione avviene sostituendo i valori anomali con la media del segnale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Svuoto lo schermo e la memoria.
clear all
close all
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scelta dei parametri.
cost = 2500;  % costante che consente di stimare il livello dei click

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carico un segnale con i click.
[x, Fs] = audioread('radioclick.wav');
soundsc(x, Fs);
t = (1:length(x))/Fs;
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
x(id) = mean(x);            % e li sostituisco con il valor medio

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Visualizzo e ascolto il risultato.
figure;
plot(t, x);
xlabel('Tempo');
ylabel('Ampiezza');
title('Audio Ripulito');
soundsc(x, Fs);
