% Struttura vuota di un generico plugin audio.
% Tale scheletro è da utilizzarsi per mappare uno script di elaborazione
% audio in un plugin.

% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

classdef mio_Plugin < audioPlugin
    % Classe del mio Plugin.
    
    properties
        % Si inizializzano tutte le proprietà utilizzate dall'utente.
    end

    properties (Access = private)
        % Si inizializzano tutte le proprietà non visibili all'utente.
    end

    properties (Constant)
        % Sezione utilizzata per costruire l'interfaccia utente.
    end

    methods
        
        function plugin = mio_Plugin
            % Instruzioni per costruire l'oggetto plugin.
        end

        function out = process(plugin, in)
            frameSize = size(in, 1);
            % Codice che implementa l'elaborazione fatta dal plugin.
        end
        
        % Aggiungere eventuali metodi di set per variare i parametri

        function reset(plugin)
            % Metodo di reset per reinizializzare il plugin.
        end
    end

end