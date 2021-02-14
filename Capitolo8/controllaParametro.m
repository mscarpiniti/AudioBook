function controllaParametro(parametro, pMin, pMax)
% Questa funzione crea l'interfaccia grafica per controllare il guadagno
% della riproduzione audio.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Range dello slider
rangeGain = linspace(pMin, pMax, 1001);
[~, id] = min(abs(rangeGain - parametro.valore));
posizione_iniziale = id/1000;

% Finestra principale
hFig = figure('Name', 'Controllo parametri', ...
   'MenuBar', 'none', 'Toolbar', 'none', ...
   'HandleVisibility', 'callback', ...
   'NumberTitle', 'off', 'IntegerHandle', 'off');

% Slider
uicontrol('Parent', hFig, 'Style', 'slider', ...
   'Position', [80, 205, 400, 23], ...
   'Value', posizione_iniziale, 'Callback', @sliderupdate);

% Etichetta per lo slider
uicontrol('Parent', hFig, 'Style', 'text', ...
   'Position', [10, 200, 70, 23], ...
   'String', parametro.nome);

% Casella di testo
pValDisplay = uicontrol('Parent', hFig, ...
   'Style', 'text', 'Position', [490, 205, 50, 23], ...
   'BackgroundColor', 'white', 'String', parametro.valore);

% Aggiornamento slider
function sliderupdate(slider, ~)
   val = get(slider, 'Value');
   rangeId = round(val*1000) + 1;
   parametro.valore = rangeGain(rangeId);
   set(pValDisplay, 'String', num2str(parametro.valore));
end

end