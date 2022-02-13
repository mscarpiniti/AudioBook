% Esempio di implementazione in tempo reale di un filtro passa-basso nel
% dominio della frequenza al fine di utilizzare la versione in tempo reale 
% dell'algoritmo di overlap and add.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


% Impostazione dei parametri
Fs = 44100;        % Frequenza di campionamento
N  = 1024;         % Dimensione del frame
M  = 256;          % Dimensione dell'input
L  = N - M;        % Dimensione dell'overlap
Nh = 512;          % Lunghezza della risposta impulsiva
LB = 192000;       % Lunghezza del buffer circolare
buffer = zeros(LB, 1);  % Buffer circolare
pt = L + 1;             % Puntatore iniziale

% Creazione filtro passa-basso (di Butterworth)
[b, a] = butter(6, 0.1);      % Sesto ordine, wt = 0.1
h = impz(b, a, Nh);
H = fft([h; zeros(N-Nh, 1)]);

% Impostazione della scheda audio
deviceReader = audioDeviceReader('SampleRate', Fs, 'SamplesPerFrame', M);
setup(deviceReader);
deviceWriter = audioDeviceWriter('SampleRate', Fs, 'BufferSize', M);
setup(deviceWriter, zeros(M, 1));

% Stream loop
tic;
while toc < 10                % Per 30 secondi
    x  = deviceReader();      % Lettura di un frame da scheda
    xb = zeros(N, 1);
    
    xb(1:M) = x;               % Copia dell'ingresso
    xb(M+1:end) = zeros(L, 1); % Zero-padding
    Xb = fft(xb);              % Trasformata di Fourier
    Yb = Xb.*H;                % Filtraggio in frequenza
    yb = real(ifft(Yb));       % Antitrasformata
    
    % Riporto indietro il puntatore di scrittura
    pt = pt - L;
    if pt < 1
        pt = pt + LB;
    end
    
    % Overlap and Add
    for i = 1:L               % Per ogni campione del frame
        buffer(pt) = buffer(pt) + yb(i);    % Sovrappongo i primi L campioni
 
        pt = pt + 1;          % Incremento del puntatore di scrittura
        if pt > LB
            pt = 1;
        end
    end
    
    for i = L+1:N
        buffer(pt) = yb(i);   % Copio gli ultimi M campioni
 
        pt = pt + 1;          % Incremento del puntatore di scrittura
        if pt > LB
            pt = 1;
        end
    end    

    % Riporto indietro il puntatore di lettura
    pt_l = pt - N;            % Puntatore di lettura
    if pt_l < 1
        pt_l = pt_l + LB;
    end
    
    % Lettura di una finestra dal buffer circolare
    y = zeros(M, 1);
    for j = 1:M               % Per ogni campione nella finestra di analisi
       y(j) = buffer(pt_l);   % Leggo dal buffer circolare
       
       pt_l = pt_l + 1;       % Incremento del puntatore di lettura
       if pt_l > LB
           pt_l = 1;
       end
    end
    
    deviceWriter(y);          % Scrittura di un frame su scheda
end

% Rilascio delle risorse audio.
release(deviceReader);
release(deviceWriter);
