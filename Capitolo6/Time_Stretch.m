% Esempio di implementazione dell'effetto time stretching.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
r  = 0.9;                     % Fattore di time stretching
N  = 2048;                    % Lunghezza della FFT
M2 = 512;                     % Step di sintesi
M1 = round(M2*r);             % Step di analisi. 
ts = M2/M1;                   % Rapporto di time stretching
L = length(x);                % Lunghezza del segnale
w = hanning(N, 'periodic');   % Finestra di Hanning
in = [zeros(N, 1); x; zeros(N-mod(L,M1), 1)];
y = zeros(N + ceil(ts*length(in)), 1);
omega = 2*pi*M1*(0:N-1).'/N;  % Vettore delle frequenze
phi0 = zeros(N, 1);           % Fase del segnale di ingresso
psi  = zeros(N, 1);           % Fase del segnale di uscita
p1 = 0;                       % Puntatore iniziale per l'ingresso
p2 = 0;                       % Puntatore iniziale per l'uscita
p_end = length(in) - N;       % Puntatore finale

% Implementazione dell'effetto
while p1 < p_end
    xk = in(p1+1:p1+N).*w;             % Segnale finestrato
    Xk = fft(xk);                      % Trafsormata di Fourier
    m  = abs(Xk);                      % Modulo dello spettro
    phi = angle(Xk);
    % ---- Calcolo dell'incremento di fase ----
    delta_phi = omega + princarg(phi - phi0 - omega);  % Eq. (6.18)
    psi = princarg(psi + delta_phi*ts);                % Eq. (6.17)
    % ---- Sintesi dell'uscita ----
    Yk = m.* exp(1j*psi);              % Sintesi dell'uscita
    yk = real(ifft(Yk)).*w;            % Segnale in uscita del k-esimo blocco
    y(p2+1:p2+N) = y(p2+1:p2+N) + yk;  % Overlap and add
    % ---- Aggiornamento dello stato ----
    phi0 = phi;
    p1 = p1 + M1;
    p2 = p2 + M2;
end

% Segnale di uscita
y = y(N+1:end);
soundsc(y, Fs);



function fase = princarg(fase_in)
% Questa funzione mappa la fase nell'intervallo (-pi,pi] [rad]

fase = mod(fase_in + pi, -2*pi) + pi;

end
