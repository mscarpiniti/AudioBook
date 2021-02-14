% Esempio di utilizzo dell'algoritmo FastICA, riscritto manualmente.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cancello l'ambiente.
clear all
close all
clc

%-----------------------------------------------------------

disp('>> Esmpio FastICA 2.......')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scelta dei parametri.
N = 3;
numIteration = 100;
W = zeros(N);
[s1, Fs] = audioread('noise.wav');   % Primo segnale
s2 = audioread('radio.wav');         % Secondo segnale
s3 = audioread('poesia.wav');        % Terzo segnale
s = [s1, s2, s3].';                  % Sorgenti
A = [1.5  -0.4  0.5; 0.5  0.4  -0.1; 0.2  -0.6  0.5];   % Matrice di mixing
x = A*s;    % Misture
for i=1:N
    soundsc(x(i, :), Fs);
    disp('>> Premi un tasto.......')
    pause
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algortimo FastICA.
disp('>> Inizio algoritmo.......')
x = x - mean(x, 2)*ones(1, length(x));
R = cov(x.');
[E, D] = eig(R);
x = sqrt(inv(D))*E.'*x;     % Sbiancamento Eq. (7.10)
y = zeros(size(x));
for k=1:N
    w = ones(N,1)/sqrt(N);
    for i=1:numIteration
        w = mean(x*(x.'*w).^3, 2) - mean(3*(x.'*w).^2)*w;  % FastICA Eq. (7.11) (FastICA con g(x)=x.^3)
        w = w/norm(w);      % Normalizzazione
    end
    W(:,k) = E*sqrt(D)*w;
    %---------------------------------------------------------
    % w = w - W * W' * w;   % Deflection: se non si sbianca
    % w = w / norm(w);
    % W(:, k) = E*sqrt(D)*w;
    %---------------------------------------------------------    
    u = w.'*x;
    y(k, :) = u;
    x = x - w*u;     % Deflation Eq. (7.12)
end

disp('>> Valutazione delle stime.......')
for i=1:N
    soundsc(y(i,:),Fs);
    disp('>> Premi un tasto.......')
    pause
end
