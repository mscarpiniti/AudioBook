% Esempio di implementazione dell'effetto sussurrato (whisperer).
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
N = 512;                       % Lunghezza della FFT
M = 64;                        % Deve essere piccolo rispetto a N
L = length(x);                 % Lunghezza del segnale
w = hanning(N, 'periodic');    % Finestra di Hanning
in = [zeros(N, 1); x; zeros(N-mod(L,M), 1)];
y = zeros(size(in));
p = 0;                         % Puntatore iniziale
p_end = length(in) - N;        % Puntatore finale

% Applicazione effetto
while p < p_end
    xk = in(p+1:p+N).*w;            % Segnale finestrato
    Xk = fft(xk);                   % Trasformata di Fourier
    m = abs(Xk);                    % Modulo dello spettro
    phi = 2*pi*rand(N, 1);          % Fase casuale
    Yk = m.*exp(1j*phi);            % Spettro ricostruito
    yk = real(ifft(Yk)).*w;         % Segnale in uscita del k-esimo blocco
    y(p+1:p+N) = y(p+1:p+N) + yk;   % Overlap and add
    p = p + M;
end

% Effetto sussurrato (whisperer)
y = y(N+1:N+L);
soundsc(y, Fs);
