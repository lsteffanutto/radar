function [cible] = simulation_cible(N,Puis_bruit,SNR,fd_normalisee,disp_cible)
%Puis_bruit en dB (puissance du bruit)
%SNR en dB
% => SNR_dB = Psignal_dB - Pnoise_dB (SNR=P_signal/P_bruit)
% => Psignal_dB = SNR_dB + Pnoise_dB
% => Psignal = 10^(Psignal,dB/10) = 10^((SNR_dB + Pnoise_dB)/10)
% Puissance signal = |s(t)|^2 et en dB ça fait 10*log10(|s(t)|^2)

Psignal_dB = SNR + Puis_bruit
P_signal_PASENDB = 10^((SNR + Puis_bruit)/10);

t=1:N;

%sinusoide spectrale = X(f) = dirac(f-fd) = e^(i2pift)
%sinusoide complexe
sinusoide= (exp(1i*2*pi*fd_normalisee*t));%+exp(-1i*2*pi*fd_normalisee*t));

cible = sqrt(P_signal_PASENDB)*sinusoide;

fech=1;
f=-(fech/2):1/N:(fech/2) -1/N; %-fech/2 à fech/2 %fréquence normalisée, 

powerscpectre = (fftshift(abs(fft(cible))).^2)/N;
%Spectre de puissance

if disp_cible==1
figure,plot(f,powerscpectre);
title('Spectre de puissance du signal')
xlabel('Fréquence normalisée')
ylabel('Puissance') % en puissance
end



end

