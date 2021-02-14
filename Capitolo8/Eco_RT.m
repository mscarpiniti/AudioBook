% Esempio di implementazione in tempo reale dell'effetto eco.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)


% Impostazione dei parametri
Fs = 44100;        % Frequenza di campionamento
N  = 1024;         % Dimensione del frame
g  = 0.5;          % Guadagno
T  = 0.5;          % Ritardo in secondi
D  = round(T*Fs);  % Ritardo in campioni
LB = D;            % Lunghezza del buffer
buffer = zeros(LB, 2);
pt = 1;

% Impostazione della scheda audio
deviceReader = audioDeviceReader('SampleRate', Fs, 'SamplesPerFrame', N, ...
    'NumChannels', 2);
setup(deviceReader);
deviceWriter = audioDeviceWriter('SampleRate', Fs, 'BufferSize', N);
setup(deviceWriter, zeros(N, 2));

% Stream loop
tic;
while toc < 30    % Per 30 secondi
    x = deviceReader();     % Lettura di un frame
    y = zeros(size(x));
       
    for i = 1:size(x, 1)    % Per ogni campione del frame
        % Tecnica del buffer circolare
        temp = buffer(pt, :);
        buffer(pt, :) = x(i, :) + g*temp;
        y(i, :) = temp;

        pt = pt + 1;        % Incremento del puntatore
        if pt > LB
            pt = 1;
        end
    end
     
    deviceWriter(y);        % Scrittura di un frame
end

% Rilascio delle risorse audio.
release(deviceReader);
release(deviceWriter);
