% Esempio di utilizzo dell'algoritmo InfoMax di Bell & Sejnowski.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cancello l'ambiente.
clear all
close all
clc

%-----------------------------------------------------------

disp('>> Esmpio InfoMax.........')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scelta dei parametri.
N = 2;            % Numero di sorgenti
mu = 0.001;       % Learning rate
epoche = 300;     % Numero di epoche
alg_type = 2;     % 1 = Gradiente stocastico  ---   2 = Gradiente Naturale
W = 0.7*(eye(N) + 0.8*rand(N));     % Matrice di demixing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carico i segnali.
[s1, Fs] = audioread('radio.wav');  % Prima sorgente
s2 = audioread('poesia.wav').';     % Seconda sorgente
s = [s1.'; s2];
for i=1:N
    soundsc(s(i, :), Fs);
    disp('>> Premi un tasto.......')
    pause
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Creo le misture.
A = [1.5  -0.4; 0.5  0.4];   % Matrice di mixing
x = A*s;                     % Misture
for i=1:N
    soundsc(x(i, :), Fs);
    disp('>> Premi un tasto.......')
    pause
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algoritmo InfoMax.  
disp('>> Inizio algoritmo.......')
P = length(x);     % Numero di campioni
B = 30;            % Lunghezza di blocco
N_blocks = fix(P/B);   % Numero di blocchi

for i = 1:epoche
    for t = 1:B:N_blocks*B
      u = W*x(:, t:t+B-1); 
      y = tanh(u);
      if alg_type == 1
         DW = inv(W') + (1 - 2*y)*x';      % Uso il gradiente stocastico
      elseif alg_type == 2
         DW = (eye(N) + (1 - 2*y)*u')*W;   % Uso il gradiente naturale (Amari)
      else
         error('Tipo di algoritmo non trovato!');
      end
      W = W + mu*DW;
    end
end
u = W*x;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ascolto stime
disp('>> Valutazione delle stime.......')
for i=1:N
    soundsc(u(i, :), Fs);
    disp('>> Premi un tasto.......')
    pause
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Valutazione delle prestazioni.
disp('>>Valuto le prestazioni.......')
Q = W*A;
SIR = evalSIR2(Q)     % Valuto il SIR
PI = evalPI(Q)        % Valuto il PI
