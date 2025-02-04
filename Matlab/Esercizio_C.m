clear; close all;

s=zpk('s');

G=(s+35)/(s^2+20*s+100);

C_s=19.1;

L_old=series(C_s,G);

margin(L_old);

[Gm,Pm,Wcg,Wcp]=margin(L_old); %gain margin, phase margin ,freq where Gm is measured, freq where Pm is measured

[mod_old, arg_old]=bode(L_old,Wcp);

delta_cr=smorz_S(0.2); % 20%

ts_max=1.2; %t_s<=1.2sec

wn_cr=3/(ts_max*delta_cr);

w_BW=wBwn(delta_cr)*wn_cr;

wc_new=7.5;

[modulo,argomento]=bode(L_old,wc_new);

m=1/modulo;

theta=56-(180-abs(argomento));

[tauz,taup]=generica(wc_new, m, theta);

C_lag=(1+tauz*s)/(1+taup*s);

C=series(C_s,C_lag);

L=series(C,G);

margin(L);

[modulo2,argomento2]=bode(L,wc_new);

T=feedback(L,1);

figure(2);

step(T);

grid;
