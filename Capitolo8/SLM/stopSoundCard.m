function stopSoundCard(figWindow)
% Tale funzione serve per terminare/riprendere l'acquisizione del misuratore
% di livello sonoro.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

% Stato dell'esecuzione.
global RUNNING
figData = get(gcbf, 'UserData');

% Rilascio delle risorse audio.
release(figData.deviceReader);

% Reinizializzo/Arresto il flusso audio.
if RUNNING
   RUNNING = 0;
   set(figData.uiButton, 'String', 'Start');
else
   delete(figWindow);
   SLM;
end