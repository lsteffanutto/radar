function [tab_modCarre_ech] = module_carre(signal)
%Renvoie le tableau des modules au carrés des échantillons

tab_modCarre_ech=abs(signal).^2;

end

