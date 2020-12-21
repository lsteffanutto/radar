clear all; close all; clc; beep off;
%https://en.wikipedia.org/wiki/Signal-to-noise_ratio

boucle=1
SNR_default=20;
nb_realisations=100;
tab_SNR=-5:20
tab_proba_bonne_detec=zeros(1,length(tab_SNR));

if boucle==0
    tab_SNR=SNR_default;
    nb_realisations=1
end

for i=1:length(tab_SNR)
    for j=1:nb_realisations 
        
%% VAR

N=64;              %Nb récurrences
K=100;             %Nb de cases distance
seuil=12;          %en dB
Puis_bruit=5;       %dB
SNR=tab_SNR(i);            %end dB
cd_cible=K/2;      %case distance de la cible
fd_normalisee=0.2; %fréquence Doppler compris entre -0.5 et 0.5

disp=1;
disp_cible=0;
%% Question 1
[BBGC] = simulation_bruit(N,K,Puis_bruit);

[cible] = simulation_cible(N,Puis_bruit,SNR,fd_normalisee,disp_cible);

signal = BBGC;
signal(cd_cible,:) = signal(cd_cible,:)+cible; %on met la cible dans la case cd_cible=50
% signal=signal';

%% Question 2

[tab_modCarre_ech] = module_carre(signal);

[CDs,Recs,nb_detec_tot] = seuillage(tab_modCarre_ech,seuil,K);

%% Question 3
%pfa = (nb fois ou case distance detecte est diff case distance cible) / N*(K-1) ou K*(N-1)
nb_bonnes_detec = sum(CDs==cd_cible);
nb_fa = nb_detec_tot-nb_bonnes_detec;

proba_bonne_detec = nb_bonnes_detec/N;
tab_proba_bonne_detec(i)=tab_proba_bonne_detec(i)+proba_bonne_detec;

nb_fa_tot=N*(K-1);
proba_mauvaise_detec = nb_fa/nb_fa_tot;

    end

end

tab_proba_bonne_detec=tab_proba_bonne_detec/nb_realisations;

[proba_bonne_detect_0_5 index_SNR_0_5]=min(find(tab_proba_bonne_detec>=0.5));
SNR_proba_bonne_detect_0_5= tab_SNR(proba_bonne_detect_0_5)

[proba_bonne_detect_0_5 index_SNR_0_9]=min(find(tab_proba_bonne_detec>=0.9));
SNR_proba_bonne_detect_0_9= tab_SNR(proba_bonne_detect_0_5)

%% PLOTS

if disp==1
figure,imagesc(20*log10(abs(signal).^2));
title('Signal obtenu en dB')
ylabel('Recurrences');
xlabel('Cases distance');
title("Nombre bonnes détecs = "+nb_bonnes_detec);
hold on;
scatter(Recs,CDs,'kX','LineWidth',2);
end

if boucle==1
figure,plot(tab_SNR,tab_proba_bonne_detec);
title('Proba bonne detec en fonction SNR')
ylabel('Proba bonne detec');
xlabel('SNR');
end

