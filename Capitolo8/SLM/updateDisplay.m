function updateDisplay(figWindow, x, X, LdBA)
% Tale funzione aggiorna l'interfaccia grafica del misuratore di livello 
% sonoro.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

figData = get(figWindow, 'UserData');
dBA_str =sprintf('%5.1f%s', LdBA, ' dBA');
set(figData.dBA_text, 'String', dBA_str);
set(figData.samplePlot, 'YData', x); 
set(figData.fftPlot, 'YData', X);
set(figWindow, 'UserData', figData);
drawnow limitrate;