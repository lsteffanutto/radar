function [CDs,Recs,nb_detections] = seuillage(mod_carre_signal,seuil,K)

% Cd_et_Recurrences_detection=find(mod_carre_signal>seuil);
[CDs,Recs]=find(mod_carre_signal>seuil);

nb_detections=length(CDs)

end

