% Esempio di implementazione dell'effetto pitch shift.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

% Impostazione dei parametri
r  = 1.2;                    % Fattore di pitch shifting
N  = 2048;                   % Lunghezza della FFT
M2 = 512;                    % Step di sintesi
M1 = round(M2/r);            % Step di analisi
ts = M2/M1;
L = length(x);               % Lunghezza del segnale
w = hanning(N, 'periodic');  % Finestra di Hanning
in = [zeros(N, 1); x; zeros(N-mod(L,M1), 1)];
y = zeros(length(in), 1);
omega = 2*pi*M1*(0:N-1).'/N;
phi0 = zeros(N, 1);          % Fase del segnale di ingresso
psi  = zeros(N, 1);          % Fase del segnale di uscita
p = 0;                       % Puntatore iniziale per l'ingresso
p_end = length(in) - 2*N;    % Puntatore finale

% Parametri per l'interpolazione lineare
Lx   = floor(N/ts);
f    = 1 + (0:Lx-1)'*N/Lx;
ix   = floor(f);
ix1  = ix + 1;
dx   = f - ix;
dx1  = 1 - dx;

% Implementazione dell'effetto
while p < p_end
    xk = in(p+1:p+N).*w;            % Segnale finestrato
    Xk = fft(xk);                   % Trafsormata di Fourier
    m  = abs(Xk);                   % Modulo dello spettro
    phi = angle(Xk);
    % ---- Calcolo dell'incremento di fase ----
    delta_phi = omega + princarg(phi - phi0 - omega);  % Eq. (6.18)
    psi = princarg(psi + delta_phi*ts);                % Eq. (6.17)
    % ---- Sintesi dell'uscita ----
    Yk  = m.* exp(1j*psi);                % Sintesi dell'uscita    
    yk1 = real(ifft(Yk)).*w;              % Segnale in uscita del k-esimo blocco
    yk2 = [yk1; 0];                       % Si aggiunge in coda uno zero
    yk3 = yk2(ix).*dx1 + yk2(ix1).*dx;    % Interpolazione lineare
    y(p+1:p+Lx) = y(p+1:p+Lx) + yk3;      % Overlap and add
    % ---- Aggiornamento dello stato ----
    phi0 = phi;
    p = p + M1;
end

% Segnale di uscita
y = y(N+1:end);
soundsc(y, Fs);



function fase = princarg(fase_in)
% Questa funzione mappa la fase nell'intervallo (-pi,pi] [rad]

fase = mod(fase_in + pi, -2*pi) + pi;

end
