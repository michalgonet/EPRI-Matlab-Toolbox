function [absorbtion first_deriv]=lorenzian_shape(x,x0,fwhm)
gamma = fwhm/sqrt(3);
absorbtion = ((2)/(pi*sqrt(3)))*(1/gamma)*(1+(4/3)*((x-x0)/gamma).^2).^-1;
first_deriv = -16/(pi*(3.^(1/3))).*((x-x0)/gamma^3).*(1+(4/3)*((x-x0)/gamma).^2).^-2;

