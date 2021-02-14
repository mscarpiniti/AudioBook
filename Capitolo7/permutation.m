function [P, D] = permutation(WA)

% Questa funzione ricava la matrice di permutazione P e quella
% diagonale D, in cui può essere scomposto il prodotto W*A
% che dovrebbe avere un solo elemento non nullo per riga.
%
%  [P, D] = permutation(WA,N);
%
%   P è la matrice di permutazione ricavata;
%   D è la matrice diagonale in uscita;
%   WA è il prodotto W*A;
%
% 16/03/2005    Michele Scarpiniti

N = size(WA, 1);
P = zeros(N);
C = abs(WA);
for i=1:N
    [~, j] = max(C(i, :));
    P(i, j) = 1;
end
if nargout == 2
    D = P*WA;        % Perchè inv(P) = P
    D = diag(diag(D));
end