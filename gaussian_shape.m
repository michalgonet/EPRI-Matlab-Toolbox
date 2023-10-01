function [absorbtion first_deriv] = gaussian_shape(x,x0,fwhm)

gamma = fwhm/sqrt(2*log(2));
absorbtion = sqrt(2/pi)*(1/gamma)*exp(-2*((x-x0)/(gamma)).^2);
first_deriv = -4*sqrt(2/pi).*(1/gamma).*((x-x0)/gamma).*exp(-2*((x-x0)/(gamma)).^2);

