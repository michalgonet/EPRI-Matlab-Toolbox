clc;clear;close all

% Definicja parametrów i stworzenie fantomu 
img_size = 512; 
nof_angle = 60; 
angle_range = linspace(180/nof_angle/2,180-180/nof_angle/2,nof_angle); 
org_img = phantom(img_size); 

% Stworzenie sinogramu
[sinogram,diag_axis]=radon(org_img,angle_range);
reco_img = zeros(img_size,img_size); 
[x,y] = meshgrid([1:img_size]-img_size/2,[1:img_size]-img_size/2); 
prj_size = 1:size(sinogram,1);
%%% Filtrowanie
sinogram_filtered = sinogram;
cut_off_freq = 1; % wspó³czynnik czêstotliwoœci odciêcia [0 1]

order = max(64,2^nextpow2(2*size(sinogram,1)));
filt = 2*( 0:(order/2) )./order;
w = 2*pi*(0:size(filt,2)-1)/order;  
filt(2:end) = filt(2:end) .* (sin(w(2:end)/(2*cut_off_freq))./(w(2:end)/(2*cut_off_freq))); % filtr Shepp-Logan
filt(w>pi*cut_off_freq) = 0;                      
filt = [filt' ; filt(end-1:-1:2)'];  
sinogram_filtered(length(filt),1)=0;  
sinogram_filtered = fft(sinogram_filtered);    
for i = 1:size(sinogram_filtered,2)
   sinogram_filtered(:,i) = sinogram_filtered(:,i).*filt;
end
sinogram_filtered = real(ifft(sinogram_filtered));     
sinogram_filtered(size(sinogram,1)+1:end,:) = [];  

% Procedura projekcji wstecznej
for i=1:length(angle_range)
    s = x*cos(pi/180*angle_range(i))+y*sin(pi/180*angle_range(i));
    reco_img = reco_img + interp1(diag_axis,sinogram_filtered(:,i),s);
end

% Wizualizacja wyników
subplot(2,2,1)
imagesc(org_img);axis square;colormap gray;
title('Oryginalny Obraz');xlabel('Rozmiar obrazu [px]'); ylabel('Rozmiar obrazu [px]');

subplot(2,2,2)
imagesc(flipud(reco_img)/pi/(2*length(angle_range)));axis square;colormap gray;
title(['Zrekonstruowany Obraz z ',num2str(nof_angle),' projekcji']);xlabel('Rozmiar obrazu [px]'); ylabel('Rozmiar obrazu [px]')

subplot(2,2,3)
imagesc(angle_range,prj_size,sinogram);title('Sinogram oryginalny');
xlabel('K¹t [deg]');ylabel('Punkt projekcji');axis square

subplot(2,2,4);
imagesc(angle_range,prj_size,sinogram_filtered);title('Sinogram przefiltrowany filterem Shepp-Logan');
xlabel('K¹t [deg]');ylabel('Punkt projekcji');axis square

