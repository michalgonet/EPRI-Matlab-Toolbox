clc;clear;close all


img_size = 512; 
nof_angle = 60; 
angle_range = linspace(180/nof_angle/2,180-180/nof_angle/2,nof_angle); 
org_img = phantom(img_size); 


[sinogram,diag_axis]=radon(org_img,angle_range);
reco_img = zeros(img_size,img_size); 
[x,y] = meshgrid([1:img_size]-img_size/2,[1:img_size]-img_size/2); 
prj_size = 1:size(sinogram,1);

sinogram_filtered = sinogram;
cut_off_freq = 1; 

order = max(64,2^nextpow2(2*size(sinogram,1)));
filt = 2*( 0:(order/2) )./order;
w = 2*pi*(0:size(filt,2)-1)/order;  
filt(2:end) = filt(2:end) .* (sin(w(2:end)/(2*cut_off_freq))./(w(2:end)/(2*cut_off_freq))); % 
filt(w>pi*cut_off_freq) = 0;                      
filt = [filt' ; filt(end-1:-1:2)'];  
sinogram_filtered(length(filt),1)=0;  
sinogram_filtered = fft(sinogram_filtered);    
for i = 1:size(sinogram_filtered,2)
   sinogram_filtered(:,i) = sinogram_filtered(:,i).*filt;
end
sinogram_filtered = real(ifft(sinogram_filtered));     
sinogram_filtered(size(sinogram,1)+1:end,:) = [];  


for i=1:length(angle_range)
    s = x*cos(pi/180*angle_range(i))+y*sin(pi/180*angle_range(i));
    reco_img = reco_img + interp1(diag_axis,sinogram_filtered(:,i),s);
end


subplot(2,2,1)
imagesc(org_img);axis square;colormap gray;

subplot(2,2,2)
imagesc(flipud(reco_img)/pi/(2*length(angle_range)));axis square;colormap gray;

subplot(2,2,3)
imagesc(angle_range,prj_size,sinogram);title
xlabel('K¹t [deg]');axis square

subplot(2,2,4);
imagesc(angle_range,prj_size,sinogram_filtered);
xlabel('K¹t [deg]');axis square

