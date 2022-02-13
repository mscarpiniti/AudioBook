% Esempio di implementazione in tempo reale di un phase vocoder nel
% dominio tempo-frequenza. Nello specifico viene implementato l'effetto
% robotico in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


% Impostazione dei parametri
Fs = 44100;        % Frequenza di campionamento
N  = 1024;         % Dimensione del frame
M  = 441;          % Dimensione dell'input
L  = N - M;        % Dimensione dell'overlap
LB = 8192;         % Lunghezza del buffer circolare
buffer_in  = zeros(LB, 1);   % Buffer circolare di input
buffer_out = zeros(LB, 1);   % Buffer circolare di output
w = hanning(N, 'periodic');  % Finestra di Hanning
pt_in = L + 1;               % Puntatore iniziale input
pt_out = L + 1;              % Puntatore iniziale output

% Impostazione della scheda audio
deviceReader = audioDeviceReader('SampleRate', Fs, 'SamplesPerFrame', M);
setup(deviceReader);
deviceWriter = audioDeviceWriter('SampleRate', Fs, 'BufferSize', M);
setup(deviceWriter, zeros(M, 1));

% Stream loop
tic;
while toc < 10                   % Per 30 secondi
    x  = deviceReader();         % Lettura di un frame da file
    xb = zeros(N, 1);
    pt_in_l = pt_in - L;         % Puntatore di lettura
    if pt_in_l < 1
        pt_in_l = pt_in_l + LB;
    end
    
    % Copia dell'input nel buffer circolare
    for i = 1:M                     % Per ogni campione del frame
        buffer_in(pt_in) = x(i);    % Scrivo sul buffer circolare
 
        pt_in = pt_in + 1;          % Incremento del puntatore di scrittura
        if pt_in > LB
            pt_in = 1;
        end
    end
    
    % Lettura di una finestra dal buffer circolare
    for j = 1:N               % Per ogni campione nella finestra di analisi
       xb(j) = buffer_in(pt_in_l) * w(j);  % Leggo dal buffer circolare e finestro
       
       pt_in_l = pt_in_l + 1;       % Incremento del puntatore di lettura
       if pt_in_l > LB
           pt_in_l = 1;
       end
    end
    
    % Applicazione dell'overlap and save
    Xb = fft(xb);             % Trasformata di Fourier
    % -- Robotico ---------------------------------------------------------
    Yb = abs(Xb);              % Solo modulo
    % -- Sussurrato -------------------------------------------------------
    % m  = abs(Xb);              % Modulo
    % phi = 2*pi*rand(N, 1);     % Fase casuale
    % Yb = m.*exp(1j*phi);       % Spettro ricostruito
    yb = real(ifft(Yb));      % Antitrasformata
       
    % Riporto indietro il puntatore di scrittura
    pt_out = pt_out - L;
    if pt_out < 1
        pt_out = pt_out + LB;
    end
    
    % Overlap and Add
    for i = 1:L               % Per ogni campione del frame
        buffer_out(pt_out) = buffer_out(pt_out) + w(i)*yb(i);    % Sovrappongo i primi L campioni
 
        pt_out = pt_out + 1;          % Incremento del puntatore di scrittura
        if pt_out > LB
            pt_out = 1;
        end
    end
    
    for i = L+1:N
        buffer_out(pt_out) = w(i)*yb(i);   % Copio gli ultimi M campioni
 
        pt_out = pt_out + 1;          % Incremento del puntatore di scrittura
        if pt_out > LB
            pt_out = 1;
        end
    end    

    % Riporto indietro il puntatore di lettura
    pt_out_l = pt_out - N;            % Puntatore di lettura
    if pt_out_l < 1
        pt_out_l = pt_out_l + LB;
    end
    
    % Lettura di una finestra dal buffer circolare
    y = zeros(M, 1);
    for j = 1:M               % Per ogni campione nella finestra di analisi
       y(j) = buffer_out(pt_in_l);   % Leggo dal buffer circolare
       
       pt_in_l = pt_in_l + 1;       % Incremento del puntatore di lettura
       if pt_in_l > LB
           pt_in_l = 1;
       end
    end
    
    deviceWriter(y);          % Scrittura di un frame su scheda
end

% Rilascio delle risorse audio.
release(deviceReader);
release(deviceWriter);

