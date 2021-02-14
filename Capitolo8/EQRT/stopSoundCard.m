function stopSoundCard(figWindow)

% Tale funzione serve per terminare/riprendere la riproduzione 
% dell'equalizzatore parametrico in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Stato dell'esecuzione.
global RUNNING
figData = get(gcbf, 'UserData');

% Rilascio delle risorse audio.
release(figData.deviceReader);
release(figData.fileReader);

% Reinizializzo/Arresto il flusso audio.
if RUNNING
   RUNNING = 0;
   set(figData.uiButton, 'String', 'Start');
else
   delete(figWindow);
   EQRT;
end