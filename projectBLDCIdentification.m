close all
%-------------------------------------------------Achizitia datelor
t=double(stoleru.X.Data)';
d=double(stoleru.Y(1,3).Data)';%semnal de comanda ce preciseaza sensul
w=double(stoleru.Y(1,2).Data)';%viteza unghiulara
theta=double(stoleru.Y(1,1).Data)';%pozitia unghiulara

figure
subplot(3,1,1);
plot(t,d);
title('Semnalul de comanda ce preciseaza sensul');
xlabel('Timpul [s]');
ylabel('Adimensional');
subplot(3,1,2);plot(t,w);
title('Viteza unghiulara');
xlabel('Timpul [s]');
ylabel('Viteza [rad/s]');
subplot(3,1,3);plot(t,theta);
title('Pozitia unghiulara');
xlabel('Timpul [s]');
ylabel('Impulsuri');

Te=t(2)-t(1);
%-----------------------------------Extragerea datelor pentru interpolare
i1=4371;
i2=4787;
i3=7972;
i4=8594;
i5=495;
i6=1105;
wi=w;
wi(i1:i2)=interp1([t(i1) t(i2)],[wi(i1) wi(i2)],t(i1:i2));
wi(i3:i4)=interp1([t(i3) t(i4)],[wi(i3) wi(i4)],t(i3:i4));
wi(i5:i6)=interp1([t(i5) t(i6)],[wi(i5) wi(i6)],t(i5:i6));
w=wi;

figure
subplot(3,1,1);
plot(t,d);
title('Semnalul de comanda ce preciseaza sensul');
xlabel('Timpul [s]');
ylabel('Adimensional');
subplot(3,1,2);
plot(t(1:i5),w(1:i5),'b');
hold on
plot(t(i5:i6),w(i5:i6),'r');
hold on 
plot(t(i6:i1),w(i6:i1),'b');
hold on
plot(t(i1:i2),w(i1:i2),'r');
hold on
plot(t(i2:i3),w(i2:i3),'b');
hold on
plot(t(i3:i4),w(i3:i4),'r');
hold on
plot(t(i4:length(t)),w(i4:length(w)),'b');
title('Viteza unghiulara');
xlabel('Timpul [s]');
ylabel('Viteza [rad/s]');
subplot(3,1,3);plot(t,theta);
title('Pozitia unghiulara');
xlabel('Timpul [s]');
ylabel('Impulsuri');


%-----------------------------------------------Identificarea datelor
t1=1055;
t2=4343;
t3=4889;
t4=7878;

figure
subplot(3,1,1);
plot(t,d);
hold on
plot(t(t1:t2),d(t1:t2),'r');
hold on
plot(t(t3:t4),d(t3:t4),'g');
title('Semnalul de comanda ce preciseaza sensul');
xlabel('Timpul [s]');
ylabel('Adimensional');
subplot(3,1,2)
plot(t,w);
hold on
plot(t(t1:t2),w(t1:t2),'r');
hold on 
plot(t(t3:t4),w(t3:t4),'g');
title('Viteza unghiulara');
xlabel('Timpul [s]');
ylabel('Viteza [rad/s]');
subplot(3,1,3);
plot(t,theta);
hold on
plot(t(t1:t2),theta(t1:t2),'r');
hold on
plot(t(t3:t4),theta(t3:t4),'g');
title('Pozitia unghiulara');
xlabel('Timpul [s]');
ylabel('Impulsuri');


data_id_w=iddata(w(t1:t2),d(t1:t2),Te);%date identificare
data_id_th=iddata(theta(t1:t2),w(t1:t2),Te);
data_v_w=iddata(w(t3:t4),d(t3:t4),Te);%date validare
data_v_th=iddata(theta(t3:t4),w(t3:t4),Te);
data_g_w=iddata(w,d,Te);%date generale
data_g_th=iddata(theta,w,Te);

%% IV4
m_iv_w=iv4(data_id_w,[1 1 1]);
figure
resid(m_iv_w,data_v_w,'corr',5);
figure
compare(m_iv_w,data_g_w)

%% OE
model_oe_th=oe(data_id_th,[1 1 1]);
figure
resid(model_oe_th,data_v_th,'corr',5);
figure
compare(model_oe_th,data_g_th)
%% Decimare
i7=6470;
i8=6290;
N=i8-i7+1;
t_dec=t(1:N:end);
d_dec=d(1:N:end);
w_dec=w(1:N:end);
th_dec=theta(1:N:end);
plot(t_dec,w_dec);
Te_dec=Te*N;
t1d=round(t1/N);
t2d=round(t2/N);
t3d=round(t3/N);
t4d=round(t4/N);

data_id_w_dec=iddata(w_dec(t1d:t2d),d_dec(t1d:t2d),Te_dec);%date identificare
data_id_th_dec=iddata(th_dec(t1d:t2d),w_dec(t1d:t2d),Te_dec);
data_v_w_dec=iddata(w_dec(t3d:t4d),d_dec(t3d:t4d),Te_dec);%date validare
data_v_th_dec=iddata(th_dec(t3d:t4d),w_dec(t3d:t4d),Te_dec);
data_g_w_dec=iddata(w_dec,d_dec,Te_dec);%date generale
data_g_th_dec=iddata(th_dec,w_dec,Te_dec);
%% Armax dec
model_armax_w_dec=armax(data_id_w_dec,[1 1 1 1]);
model_armax_th_dec=armax(data_id_th_dec,[1 1 1 1]);

figure
resid(model_armax_w_dec,data_v_w_dec,'corr',15);
figure
compare(model_armax_w_dec,data_g_w_dec);
legend();

%% Arx dec
model_arx_w_dec=arx(data_id_w_dec,[1 1 1]);
model_arx_th_dec=arx(data_id_th_dec,[1 1 1]);

figure
resid(model_arx_th_dec,data_v_th_dec,'corr',15);
figure
compare(model_arx_th_dec,data_g_th_dec)
%% fct de transfer 
H_iv_w=tf(m_iv_w);
H_oe_th=tf(model_oe_th);
H_w_d_iv=d2c(H_iv_w,'zoh');
H_oe_d_th=d2c(H_oe_th,'zoh');
H_oe_d_th=tf([5.152],[1 0]);
H_fin_inter=series(H_w_d_iv,H_oe_d_th)


H_armax_w=tf(model_armax_w_dec);
H_arx_th=tf(model_arx_th_dec);
H_arx_th=d2c(H_arx_th,'zoh');
H_w_d_armax=d2c(H_armax_w,'zoh');
H_th_d_arx=tf([5.134],[1 0]);

H_fin_auto=series(H_th_d_arx,H_w_d_armax)

A=[-13.25 0;5.134 0];
B=[3222; 0];
C=[0 1]; D=0;
th_aut=lsim(A,B,C,D,d,t,[w(1) theta(1)]);
plot(t,[th_aut theta]);