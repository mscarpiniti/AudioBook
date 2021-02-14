% Esempio di implementazione di un ritardo frazionario utilizzando un 
% buffer circolare con due puntatori
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('audio.wav');
buffer = zeros(LB, 1);
pt = 1;
D = 92.4;   % Esempio di ritardo frazionario

M = floor(D);           % Parte intera
alpha = D - M;          % Parte frazionaria

for n = 1:length(x)
    buffer(pt) = x(n);  % Inserimento di un nuovo campione
    pl = pt - M;        % Puntatore di lettura
    if (pl > LB)
        pl = pl - LB;
    elseif (pl < 0)
        pl = pl + LB;
    end

    if (pl == LB)        % Interpolazione lineare
        rit = (1 - alpha)*buffer(pl) + alpha*buffer(1);   
    else
        rit = (1 - alpha)*buffer(pl) + alpha*buffer(pl+1);
    end

    pt = pt + 1;     % Aggiornamento puntatore scrittura
    if (pt > LB)
        pt = 1;
    end
end
