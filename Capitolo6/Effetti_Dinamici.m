% Esempio di implementazione degli effetti dinamici
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');

livello = 0.0001;  % Livello iniziale
S_NG = -70;        % Soglia NG
S_E = -35;         % Soglia espansore
S_C = -20;         % Soglia compressore
S_L = 10;          % Soglia limiter

R_C = 4;           % Ratio compressore
R_E = 0.1;         % Ratio espansore

T  = 0.75;         % Costante di tempo RMS
Ta = 0.75;         % Costante di tempo di attacco
Tr = 0.5;          % Costante di tempo di rilascio
tipo = 'RMS';
y = zeros(size(x));
g = zeros(size(x));


% Aggiunta di dinamiche
x(45000:90000) = 8*x(45000:90000);
x(210000:250000) = 0.3*x(210000:250000);
x(300000:330000) = 15*x(300000:330000);


for n=2:length(x)
    if strcmp(tipo, 'picco')
        livello = valore_picco(x(n), livello, [Ta, Tr]);
        L = mag2db(livello);   % Conversione in dB
    elseif strcmp(tipo, 'RMS')
        livello = valore_RMS(x(n), livello, T);
        L = pow2db(livello);   % Conversione in dB
    end		

    if ((L < S_C) && (L > S_E))        % Lineare
        G = 0;
    elseif (L < S_NG)                  % Noise Gate
        G = -Inf;                      % Eq. (6.14)
    elseif ((L < S_E) && (L >= S_NG))  % Espansore
        G = (1 - 1/R_E)*(S_E - L);     % Eq. (6.13)
    elseif ((L < S_L) && (L >= S_C))   % Compressore
        G = (1 - 1/R_C)*(S_C - L);     % Eq. (6.11)
    else                               % Limiter
        G = S_L - L;                   % Eq. (6.12)
    end
    g(n) = db2mag(G);                  % Conversione in grandezza naturale
    g(n) = 0.5*g(n) + 0.5*g(n-1);      % Filtraggio passa-basso
    y(n) = g(n)*x(n);                  % Eq. (6.10)
end

% soundsc(y, Fs);


% Valore di picco
function xp = valore_picco(x, xp_1, t)
% Funzione che calcola il valore di picco
% La variabile t è un vettore di due elementi [t_att, t_rel]

   xM = abs(x);
   if xM > xp_1
       tau = t(1);  % Attacco
   else
       tau = t(2);  % Rilascio
   end

   xp = tau*xM + (1 - tau)*xp_1;   % Eq. (6.15)
end


% Valore RMS
function xRMS = valore_RMS(x, xRMS_1, tm)
% Funzione che calcola il valore RMS

   xRMS = tm*x.^2 + (1 - tm)*xRMS_1;   % Eq. (6.16)
end