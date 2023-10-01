clc;clear;close all

pkt = 64;
x = linspace(1,pkt,pkt);
x0 = round(pkt/2);
fwhm = 20;
[L,l] = lorenzian_shape(x,x0,fwhm);

new_pkt = 32;

old = linspace(1,pkt,pkt);
new = linspace(1,pkt,new_pkt);

l_new = interp1(old,l,new);

plot(old,l,'ko-',new,0.01+l_new,'kd-');
legend(['Oryginalne widmo; ',num2str(pkt),' pkt'],['Interpolowane widmo; ',num2str(new_pkt),' pkt'])

