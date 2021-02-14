% Classe di esempio che sviluppa un semplice plugin che implementa un eco e
% in cui è possibile variare il ritardo dell'eco e la sua ampiezza.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

classdef Eco_Plugin < matlab.System & audioPlugin

    properties
        Guadagno = 1.5;
        Ritardo  = 0.5;
    end

    properties (Access = private)
        BufferCircolare = zeros(192001, 2);  % Stereofonico
        Indice = 1;
        N_Camp = 0;
    end

    properties (Constant)
        PluginInterface = audioPluginInterface(...
            audioPluginParameter('Guadagno', ...
            'DisplayName','Guadagno Eco', ...
            'Mapping', {'lin',0,3}), ...
            audioPluginParameter('Ritardo',...
            'DisplayName', 'Ritardo Eco',...
            'Label', 'secondi'))
    end

    methods(Access = protected)
        function out = stepImpl(plugin, in)
            out = zeros(size(in));
            p_s = plugin.Indice;
            p_l = p_s - plugin.N_Camp;
            if p_l <= 0
                p_l = p_l + 192001;
            end
            
            for i = 1:size(in,1)
                plugin.BufferCircolare(p_s,:) = in(i,:);
                
                eco = plugin.BufferCircolare(p_l,:);
                out(i,:) = in(i,:) + eco*plugin.Guadagno;
                
                p_s = p_s + 1;
                if p_s > 192001
                    p_s = 1;
                end
                
                p_l = p_l + 1;
                if p_l > 192001
                    p_l = 1;
                end
            end
            plugin.Indice = p_s;
        end
    end
    
    methods
        function set.Ritardo(plugin, valore)
            plugin.Ritardo = valore;
            plugin.N_Camp = floor(getSampleRate(plugin)*valore);
        end
    end

end