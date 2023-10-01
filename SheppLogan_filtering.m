function sinogram_filtered = SheppLogan_filtering(sinogram,cut_off_freq)
order = max(64,2^nextpow2(2*size(sinogram,1)));
filt = 2*( 0:(order/2) )./order;
w = 2*pi*(0:size(filt,2)-1)/order;  
filt(2:end) = filt(2:end) .* (sin(w(2:end)/(2*cut_off_freq))./(w(2:end)/(2*cut_off_freq)));
filt(w>pi*cut_off_freq) = 0;                      
filt = [filt' ; filt(end-1:-1:2)'];  
sinogram_filtered = sinogram;
sinogram_filtered(length(filt),1)=0;  
sinogram_filtered = fft(sinogram_filtered);    
for i = 1:size(sinogram_filtered,2)
   sinogram_filtered(:,i) = sinogram_filtered(:,i).*filt;
end
sinogram_filtered = real(ifft(sinogram_filtered));     
sinogram_filtered(size(sinogram,1)+1:end,:) = [];  
