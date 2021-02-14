function SIR = evalSIR(s,Q)
% Valuta l'indice SIR per ogni sorgente separata.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

N = size(s,1); 
SIR = zeros(1,N);
P = permutation(Q);
for i=1:N
    [~, q] = max(P(i,:));
    sn = zeros(size(s));
    sn(i,:) = s(i,:);
    un = Q*sn;
    sig = 0;
    noise = 10^-17;  % Evita la divisione per 0
    for k=1:N
        if k == q
            sig = abs(sum(un(k,:).^2));
        else
            noise = noise + abs(sum(un(k,:).^2));
        end
    end
    SIR(i) = 10*log10(sig./noise);
end