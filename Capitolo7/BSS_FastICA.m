% Esempio di utilizzo della funzione FastICA di Hyvärinen.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cancello l'ambiente.
clear all
close all
clc

%-----------------------------------------------------------

disp('>> Esmpio FastICA 1.......')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scelta dei parametri.
[s1, Fs] = audioread('noise.wav');   % Primo segnale
s2 = audioread('radio.wav');         % Secondo segnale
s3 = audioread('poesia.wav');        % Terzo segnale
s = [s1, s2, s3].';
A = [1.5  -0.4  0.5; 0.5  0.4  -0.1; 0.2  -0.6  1.3];   % Matrice di mixing
x = A*s;    % Misture

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algortimo FastICA.
[y, ~, W] = fastica(x, 'displayMode', 'on');
for i=1:3
    soundsc(y(i,:),Fs);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valutazione delle prestazioni.
disp('>> Valutazione delle prestazioni.......')
Q = W*A;
SIR = evalSIR2(Q)      % Valuto il SIR
PI = evalPI(Q)         % Valuto il PI
