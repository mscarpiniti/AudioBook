% Esempio di utilizzo dell'algoritmo di estrazione di sorgenti (BSE)
% Desideriamo estrarre solo una sorgente dalle tre misture e precisamente
% quella con curtosi più elevata (poesia.wav)

% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cancello l'ambiente.
clear all
close all
clc

%-----------------------------------------------------------

disp('>> Esmpio BSE..........')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Scelta dei parametri.
N = 3;     % Numero di sorgenti
M = 1;     % Numero di segnali da estrarre
eta = 3e-7;
numIteration = 100;
W = zeros(N);
[s1, Fs] = audioread('noise.wav');   % Primo segnale
s2 = audioread('radio.wav').';       % Secondo segnale
s3 = audioread('poesia.wav').';      % Terzo segnale
s = [s1.'; s2; s3];
A = [1.5  -0.4  0.5; 0.5  0.4  -0.1; 0.2  -0.6  0.5];   % Matrice di mixing
x = A*s;    % Misture
for i=1:N
    soundsc(x(i, :), Fs);
    disp('>> Premi un tasto.......')
    pause
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algortimo BSE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-----------------------------------------------------------
% Centramento e Sbiancamento
disp('>> Inizio algoritmo.......')
x = x - mean(x, 2)*ones(1, length(x));
R = cov(x.');
[E,D] = eig(R);
x = sqrt(inv(D))*E.'*x;

%-----------------------------------------------------------
% Estrazione
y = zeros(size(x));
for i = 1:M
    w = ones(N, 1)/sqrt(N);
    for t = 1:numIteration
        u = w.'*x;
        k = kurtosis(u) - 3;
        b = sign(k);
        m4 = moment(u, 4);
        m2 = moment(u, 2);
        phi = b*(m4./(m2.^3))*((u.^3)*m2'/m4' - u);
        Dw = eta*x*phi.';
        w = w + Dw;
        w = w/norm(w);     
    end
%-----------------------------------------------------------
% Deflation
    W(:,i) = w;
    u = w.'*x;
    w = (cov(x.')*w)/var(u);
    x = x - w*u;
    %x = x/norm(x);
    y(i,:) = u;
    fprintf('Estrazione sorgente %d su %d di %d misture........ \n', i, M, N);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ascolto delle stime
disp('>> Valutazione delle stime.......')
for i=1:M
    soundsc(y(i,:),Fs);
    disp('>> Premi un tasto.......')
    pause
end
