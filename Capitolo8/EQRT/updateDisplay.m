function updateDisplay(figWindow, H)

% Tale funzione aggiorna l'interfaccia grafica dell'equalizzatore parametrico 
% in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

figData = get(figWindow, 'UserData');
set(figData.hPlot, 'YData', 20*log10(H));
set(figWindow, 'UserData', figData);
drawnow limitrate;