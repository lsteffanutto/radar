function [BBGC] = simulation_bruit(N,K,Puis_bruit)
%Génère un tableau de taille [KxN] représentant un bruit complexe gaussien

Puis_bruit_PASENDB=10^(Puis_bruit/10);

sigma2=Puis_bruit_PASENDB;

BBGC=sqrt(sigma2/2)*randn(K,N)+1i*sqrt(sigma2/2)*randn(K,N); %Pnoise=10^(Pnoise,dB/10)

end

