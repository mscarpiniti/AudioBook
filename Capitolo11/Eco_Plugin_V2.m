% Seconda versione del plugin che implementa un eco e in cui è possibile 
% variare il ritardo dell'eco e la sua ampiezza. A differenza della prima
% versione, in questa si utilizza il layout dividendo la finestra in una
% griglia di 3x4 celle in cui posizionare i controlli. In aggiunta, si è
% utilizzato un interruttore a levetta per abilitare e disabilitare
% l'effetto.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

classdef Eco_Plugin_V2 < audioPlugin

    properties
        Guadagno = 0.5;
        Ritardo  = 0.5;
        Abilita = true;
    end

    properties (Access = private)
        BufferCircolare = zeros(192001, 2);  % Stereofonico
        Indice = 1;
        N_Camp = 0;
    end

    properties (Constant)
        PluginInterface = audioPluginInterface(...
            audioPluginParameter('Guadagno', ...
            'Mapping', {'lin',0,1}, ...
            'Style', 'vslider', ...
            'Layout', [2,1;3,1], ...
            'DisplayName','Guadagno Eco', ...
            'DisplayNameLocation','Above'), ...
            audioPluginParameter('Ritardo',...
            'Mapping', {'lin',0,1.5}, ...
            'Style', 'rotaryknob', ...
            'Layout', [2,3;3,3], ...
            'Label', 'secondi', ...
            'DisplayName', 'Ritardo Eco',...
            'DisplayNameLocation','Above'), ...
            audioPluginParameter('Abilita', ...
                'Style', 'vtoggle', ...
                'Layout', [2,4], ...
                'DisplayNameLocation', 'None'), ...   
            ...
            audioPluginGridLayout( ... 
                'RowHeight',[20, 160, 20], ... 
                'ColumnWidth',[100, 50, 150, 100], ...
                'RowSpacing', 15, 'ColumnSpacing', 15, ...
                'Padding', [25, 25, 25, 25]))
    end

    methods
        function out = process(plugin, in)
            out = zeros(size(in));
            p_s = plugin.Indice;
            p_l = p_s - plugin.N_Camp;
            if p_l <= 0
                p_l = p_l + 192001;
            end
            
            for i = 1:size(in,1)
                plugin.BufferCircolare(p_s,:) = in(i,:);
                
                eco = plugin.BufferCircolare(p_l,:);
                if plugin.Abilita
                    out(i,:) = in(i,:) + eco*plugin.Guadagno;
                else
                    out(i,:) = in(i,:);
                end
                
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

        function set.Ritardo(plugin, valore)
            plugin.Ritardo = valore;
            plugin.N_Camp = floor(getSampleRate(plugin)*valore);
        end
 
        function reset(plugin)
            plugin.BufferCircolare = zeros(192001, 2);
            plugin.N_Camp = floor(getSampleRate(plugin)*plugin.Ritardo);
        end
    end

end