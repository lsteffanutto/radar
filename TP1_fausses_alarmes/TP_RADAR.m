clear all; close all; clc; beep off;

%% 1
Nrealisation=100000;     %réalisations
Nobs=10;  %observations => baisse observations ça se recouvre
sigma2_b=2; %variance du bruit
m=4;
% Ho_Ri= 1/sqrt(2*pi*N*sigma2_b) * exp(-R^2/(2*N*sigma2_b))       %Ho = full bruit

Ri_H0=sqrt(sigma2_b)*randn(Nobs,Nrealisation);  %H0 => R_i=n_i
Ri_H1=m+sqrt(sigma2_b)*randn(Nobs,Nrealisation);%H1 => R_i=m+n_i

s_Ri_H0=sum(Ri_H0);
s_Ri_H1=sum(Ri_H1);

% P_R_H0= 1/sqrt(2*pi*N*sigma2_b) * exp(-((s_Ri_H0.^2)/(2*N*sigma2_b)));

figure,
histogram(s_Ri_H0);
hold on;histogram(s_Ri_H1);
title("quantités P(R|H0) et P(R|H1)");


%% 2
pfa_fix=0.01;
var=2;
data=sqrt(sigma2_b)*randn(Nobs,Nrealisation);
hasard=randi([0 1],1,Nrealisation); % 1=H1 et 0=H0

obs=zeros(Nobs,Nrealisation);
obs=data+m*hasard; %on ajoute la moyenne au ligne quand hasard=1

lambda_visuel=20;

lambda_theorique=sqrt(2*Nobs*var)*erfcinv(2*pfa_fix) % => dégueu par rapport à lambda_visuel=20

s_Ri_obs=sum(obs);
s_Ri_data=sum(data);

% rapport_vrai=s_Ri_obs/s_Ri_data

decision=s_Ri_obs>lambda_theorique;

diff_has_dec=find(hasard~=decision);
nb_diff_hasard_decision=length(diff_has_dec)
nb_fausse_alarme=0;
nb_detec_manque=0;

for i=1:nb_diff_hasard_decision
    
    if (decision(diff_has_dec(i))==1 & hasard(diff_has_dec(i))==0)
        nb_fausse_alarme=nb_fausse_alarme+1;
    end
    
    if (decision(diff_has_dec(i))==0 & hasardd(iff_has_dec(i))==1)
        nb_detec_manque=nb_detec_manque+1;
    end
    
    
end

nb_fausse_alarme
nb_detec_manque  
nb_hasard_0=sum(hasard==0)
nb_hasard_1=sum(hasard==1)

pfa_exp = nb_fausse_alarme/nb_hasard_0 %sur nombre de fois ou hasard=0
p_detection_manque = nb_detec_manque/nb_hasard_1;
pd_exp = 1-p_detection_manque        
       
%seuil fonction pfa
%seuil fonction var
%seuil fonction m
%m va grandir, proba detection grande

pfa_var=0.01:0.01:0.1

seuil=sqrt(2*Nobs*var)*erfcinv(2*pfa_var)

figure,plot(pfa_var,seuil)
title('seuil en fonction pfa')

var_var=2:0.1:10

seuil=sqrt(2*Nobs*var_var)*erfcinv(2*pfa_fix)

figure,plot(var_var,seuil)
title('seuil en fonction var')

%faire une boucle pour m
% m_var=4:1:20
% 
% seuil=sqrt(2*Nobs*var)*erfcinv(2*pfa_fix)
% 
% figure,plot(var_var,seuil)
% title('seuil en fonction m')





