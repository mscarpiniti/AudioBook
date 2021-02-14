% Esempio di implementazione di un algoritmo per la cancellazione
% adattative del rumore (ANC) basato sul filtro adattativo di tipo LMS.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Impostazione dei parametri
mu = 0.0005; % Learning rate
M = 128; % Lunghezza del filtro
w = zeros(M, 1);

% Lettura dei segnali
[s, Fs] = audioread('radio.wav');   % Segnale utile
[eta, ~] = audioread('noise.wav');  % Segnale di rumore
load hs   % Risposta impulsiva del segnale
load hn   % Risposta impulsiva del rumore
eta1 = filter(hn(1:128), 1, eta);   % Rumore al rif. primario
s1 = filter(hs(1:128), 1, s);       % Segnale al rif. primario
d = s1 + 0.5*eta1;                  % Riferimento primario
x = zeros(M, 1);                    % Buffer di ingresso
y = zeros(1, length(eta));

% Ciclo principale
for k = 1:length(eta)        % Per ogni campione
    x = [eta(k); x(1:M-1)];  % Scorrimento del buffer
    y(k) = w.'*x;            % Calcolo dell'uscita
    e = d(k) - y(k);         % Calcolo dell'errore
    w = w + mu*e*x;          % Aggiornamento LMS in Eq. (7.5)
end

y = filter(w, 1, eta);   % Calcolo dell'uscita del filtro adattato
e = d - y;               % Segnale di errore
soundsc(e, Fs);          % Ascolto del risultato
