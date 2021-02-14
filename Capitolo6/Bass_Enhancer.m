% Algoritmo per enfatizzare la parte bassa di un segnale audio (bass
% enhancer) ispirata aad un principio psico-acustico.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

[x, Fs] = audioread('RockGuitar-16-44p1-stereo-72secs.wav');

% Impostazione parametri
ft = 60;     % Frequenza di taglio del crossover
f1a = 60;    % Prima frequenza di taglio del filtro passa-banda
f1b = 80;
f2a = 240;   % Seconda frequenza di taglio del filtro passa-banda
f2b = 300;
G  = 0.05;   % Guadagno applicato al filtro passa-banda
Nc = 4;      % Ordine dei filtri del crossover
Ac = 60;     % Attenuazione del filtro crossover
Ap = 40;     % Attenuazione del filtro passa-banda
Rp = 8;      % Ripple in banda passante

% Filtro crossover
wt = ft/(Fs/2);
[b_pb, a_pb] = cheby2(Nc, Ac, wt);
[b_pa, a_pa] = cheby2(Nc, Ac, wt, 'high');
x_pb = filter(b_pb, a_pb, x);
x_pa = filter(b_pa, a_pa, x);

% Selezione canali e canale monofonico
u = sum(x_pb, 2);
x_pa_L = x_pa(:, 1);
x_pa_R = x_pa(:, 2);

% Full-wave integrator
r = zeros(size(u));
r(1) = abs(u(1));
for n=2:length(u)
    if ((u(n) > 0) && (u(n-1) <= 0))
        r(n) = 0;
    else
        r(n) = abs(u(n-1)) + r(n-1);
    end
end
r(r > 0.15) = 0.05;

% Filtro passa-banda
wtp = [f1b f2a]/(Fs/2);
wts = [f1a f2b]/(Fs/2);
% [N, ws] = cheb2ord(wtp, wts, Rp, Ap);
% [b, a] = cheby2(N, Ap, ws);
[N, ws] = ellipord(wtp, wts, Rp, Ap);
[b, a] = ellip(N, Rp, Ap, ws, 'bandpass');
s = filter(b, a, r);
s = G*s;

% Ricostruzione segnale di uscita
y1 = s + x_pa_L;
y2 = s + x_pa_R;
y = [y1, y2];

% Ascolto del segnale ricostruito
soundsc(y, Fs);
