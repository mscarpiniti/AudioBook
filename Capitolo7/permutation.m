function [P, D] = permutation(WA)

% Questa funzione ricava la matrice di permutazione P e quella
% diagonale D, in cui pu� essere scomposto il prodotto W*A
% che dovrebbe avere un solo elemento non nullo per riga.
%
%  [P, D] = permutation(WA,N);
%
%   P � la matrice di permutazione ricavata;
%   D � la matrice diagonale in uscita;
%   WA � il prodotto W*A;
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
    D = P*WA;        % Perch� inv(P) = P
    D = diag(diag(D));
end