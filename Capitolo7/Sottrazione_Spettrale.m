% Esempio di implementazione di un algoritmo per sottrazione spettrale di
% un rumore a larga banda. Viene implementata anche la stima dell'SNR a
% priori.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('radio_rumorosa.wav');

% Impostazione dei parametri
apriori_SNR = 1;   % 0 per a posteriori SNR, 1 per a priori
alpha = 0.05;      % Solo per apriori_SNR=1
beta = 1;          % Il beta nella (7.7)
lambda = 3;        % Il lambda nella (7.7)
NFFT = 1024;
window_length = round(0.031*Fs);      % Lunghezza della finestra
finestra = hamming(window_length);    % Finestra di Hamming
overlap = floor(0.45*window_length);  % Numero di campioni di overlap

% Finestra di stima del rumore (in secondi)
t_min = 0.00;
t_max = 0.20;

% Stima dello spettro di rumore
[X, F, T] = spectrogram(x, finestra, window_length - overlap, NFFT, Fs);
[Nf, Nw] = size(X);

t_index = T>t_min & T<t_max;    % Finestra con solo rumore
absX_noise = abs(X(:, t_index)).^2;
noise_spectrum = mean(absX_noise,2);    % Spettro medio (supposto ergodico)
noise_specgram = repmat(noise_spectrum, 1, Nw);

% Stima dell'SNR a priori
absX = abs(X).^2;
SNR_est = max((absX./noise_specgram)-1, 0);           % SNR a priori
if apriori_SNR == 1
    SNR_est = filter((1-alpha), [1 -alpha], SNR_est); % Stima SNR in Eq. (7.6)
end

% Determinazione del filtro per la rimozione del rumore
H = max((1 - lambda*((1./(SNR_est + 1)).^0.5)).^beta, 0); % Eq. (7.7)
STFT = H.*X;       % Spettro del segnale ripulito

% Ricostruzione del segnale di uscita con l'overlap and add (OA)
ind = mod((1:window_length)-1, Nf) + 1;
y = zeros((Nw-1)*overlap + window_length, 1);
for indice = 1:Nw       % Tecnica dell'Overlapp and Add
    left_index = ((indice-1)*overlap);
    index = left_index + (1:window_length);
    temp_ifft = real(ifft(STFT(:,indice), NFFT));
    y(index) = y(index) + temp_ifft(ind).*finestra;  % Segnale ripulito
end
