function deconv_spectrum = deconvolution(grad_spectrum,non_grad_spectrum,filt)
non_grad_spectrum = non_grad_spectrum';
points = length(grad_spectrum); 
axis = linspace(0,1024,points); 
h =sqrt(2/pi)*(1/(filt/sqrt(2*log(2))))*exp(-2*((axis)/(filt/sqrt(2*log(2)))).^2);
h = h'/max(h);
deco_temp = ifft((fft(grad_spectrum').*h)./(fft(non_grad_spectrum)));
deco_temp = ifftshift(deco_temp);
deconv_spectrum=(real(deco_temp));

