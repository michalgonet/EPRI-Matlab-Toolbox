clc;clear;close all

% Zdefiniowanie oryginalnego widma
pkt = 64;
x = linspace(1,pkt,pkt);
x0 = round(pkt/2);
fwhm = 20;
[L,l] = lorenzian_shape(x,x0,fwhm);

% Liczba punkt�w 
new_pkt = 32;

old = linspace(1,pkt,pkt);
new = linspace(1,pkt,new_pkt);

% Interpolacja
l_new = interp1(old,l,new);

% Wizualizacja wynik�w
plot(old,l,'ko-',new,0.01+l_new,'kd-');
legend(['Oryginalne widmo; ',num2str(pkt),' pkt'],['Interpolowane widmo; ',num2str(new_pkt),' pkt'])

