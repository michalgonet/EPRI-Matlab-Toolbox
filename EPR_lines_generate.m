clc;clear;
% close all
pkt = 1024;
x = linspace(1,pkt,pkt);
x0 = pkt/2;
fwhm = 100;


[G1,g1] = gaussian_shape(x,x0-100,1.1*fwhm);
[G2,g2] = gaussian_shape(x,x0+50,1.5*fwhm);
[R, r] = gaussian_shape(x,x0-5,1.4*fwhm);

% [G1,g1] = gaussian_shape(x,x0-100,1*fwhm);
% [G2,g2] = gaussian_shape(x,x0+50,1*fwhm);
% [R, r] = gaussian_shape(x,x0-5,1.4*fwhm);

proj = zeros(2*pkt,1);
proj(1:pkt) = g1*2;
proj(pkt+1:end) = g2;

% plot(proj,'black','linewidth',2);axis off

old = 1:2*pkt;
new = linspace(1,2*pkt,pkt);
proj1 = interp1(old,proj,new);
proj = proj1;

% plot(proj);
ff = 5.7;
W = deconvolution(proj,r,ff);
% plot(W)
% plot(r);hold on 
% plot(proj);
axis off
% subplot(1,3,1)
% plot(proj,'black','linewidth',2);axis off

% subplot(1,3,2)
% plot(r,'black','linewidth',2);axis off
% 
% subplot(1,3,3)
plot(W,'black','linewidth',2);axis off


