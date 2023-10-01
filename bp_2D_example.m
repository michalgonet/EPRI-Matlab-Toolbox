clc;clear;close all


img_size = 100; 
nof_angle = 180; 
angle_range = linspace(1,180,nof_angle); 
org_img = phantom(img_size); 


[sinogram,diag_axis]=radon(org_img,angle_range);

reco_img = zeros(img_size,img_size); 
[x,y] = meshgrid([1:img_size]-img_size/2,[1:img_size]-img_size/2); 



for k=1:length(angle_range)
    s = x*cos(pi/180*angle_range(k))+y*sin(pi/180*angle_range(k));
    reco_img = reco_img + interp1(diag_axis,sinogram(:,k),s);
end


imagesc(flipud(reco_img)/pi/(2*length(angle_range)));
colormap gray;axis square
