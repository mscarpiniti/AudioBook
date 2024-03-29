classdef MiaClasse
% Una classe con due proprietÓ e due metodi che calcolano
% la somma e il prodotto delle due proprietÓ.
% Utilizzo:
%   m = MiaClasse;
%
% Vedi anche: ....

   properties(Access = private)
      a = 3;  % Primo parametro
      b = 2;  % Secondo parametro
   end
   
   properties(Constant)
       c = 3.14;
   end

   methods
      function s = Somma(obj)
      % Calcola la somma delle due proprietÓ
         s = obj.a + obj.b;  % Semplice esempio
      end

      function p = Prodotto(obj)
      % Calcola il prodotto delle due proprietÓ
         p = obj.a * obj.b;
      end
      
   end
   
   methods(Static)
      function s = descrizione()
         s = 'Classe per gestire il mio progetto...';
      end
   end

end