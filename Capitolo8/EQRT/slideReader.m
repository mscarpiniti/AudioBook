function G = slideReader(figWindow)

% Tale funzione aggiorna l'interfaccia grafica dell'equalizzatore parametrico 
% in tempo reale.
%
% M. Scarpiniti (Dip. DIET - Sapienza Università di Roma)

figData = get(figWindow, 'UserData');

G1 = figData.S1.Value;
G2 = figData.S2.Value;
G3 = figData.S3.Value;
G4 = figData.S4.Value;
G5 = figData.S5.Value;
G6 = figData.S6.Value;
G7 = figData.S7.Value;
G8 = figData.S8.Value;
G9 = figData.S9.Value;
G10 = figData.S10.Value;

G = [G1, G2, G3, G4, G5, G6, G7, G8, G9, G10];
