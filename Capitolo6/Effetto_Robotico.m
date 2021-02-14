% Esempio di implementazione dell'effetto robotico.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
N = 1024;                    % Lunghezza della FFT
M = 441;                     % Step di analisi. La voce robotica avrà un pitch di Fs/M = 100 Hz
L = length(x);               % Lunghezza del segnale
w = hanning(N, 'periodic');  % Finestra di Hanning
in = [zeros(N, 1); x; zeros(N-mod(L,M), 1)];
y = zeros(size(in));
p = 0;                       % Puntatore iniziale
p_end = length(in) - N;      % Puntatore finale

% Applicazione effetto
while p < p_end
    xk = in(p+1:p+N).*w;            % Segnale finestrato
    Xk = fft(xk);                   % Trafsormata di Fourier
    m = abs(Xk);                    % Modulo dello spettro
    yk = real(ifft(m)).*w;          % Segnale in uscita del k-esimo blocco
    y(p+1:p+N) = y(p+1:p+N) + yk;   % Overlap and add
    p = p + M;
end

% Effetto robotico
y = y(N+1:N+L);
soundsc(y, Fs);
