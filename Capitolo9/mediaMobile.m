% Implementazione della classe mediaMobile oer la creazione un oggetto di 
% sistema che gestisce l'audio in tempo reale.
% Si faccia attenzione che l'oggetto si aspetta un vettor (o matrice)
% organizzata per colonne, come è comune in ambito audio.

% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

classdef mediaMobile < matlab.System

    properties(Nontunable)
        WindowLength = 5;
    end

    properties(Access = private)
        Stato;
        NumCanali = -1;
        Coefficienti;
    end

    methods
        function obj = mediaMobile(varargin)
            % Costruttore
            setProperties(obj, nargin, varargin{:})
        end
    end

    methods (Access = protected)
		
		    function setupImpl(obj, x)
        % Inizializzazione
            obj.NumCanali = size(x, 2);
            obj.Coefficienti = ones(1, obj.WindowLength)/obj.WindowLength;
            %obj.Stato = zeros(obj.WindowLength-1, obj.NumCanali);
            obj.Stato = zeros(obj.NumCanali, obj.WindowLength-1);
        end
      
       function y = stepImpl(obj, x)
       % Implementa l'algoritmo di elaborazione
          [y, obj.Stato] = filter(obj.Coefficienti, 1, x, obj.Stato);
       end    

       function resetImpl(obj)
       % Reset
           obj.Stato(:) = 0;
       end

       function releaseImpl(obj)
       % Rilascio delle risorse
           obj.NumCanali = -1;
       end   
		
		end
end
