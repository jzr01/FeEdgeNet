function [x, f] = pluralKernel_Gaussian(thickness,fwhm_zlp,fwhm_loren)
%thickness is in unit of t/lambda
%fwhm_zlp is the fwhm of the zero-loss peak
%fwhm_loren is the fwhm of the lorenztian shape
%f is the plural scattering kernel 
%x is the energy axis (in eV)


if nargin==1
    fwhm_zlp = 1.5;
    fwhm_loren = 0.1;
elseif nargin==0
    thickness = 3;
    fwhm_zlp = 1.5;
    fwhm_loren = 0.1;
end

dx = 0.02;
x = -150:dx:150;


fwhm = 20;
sigma = fwhm./(2*sqrt(2*log(2)));
func_gauss = exp(-(x-25).^2/(2*sigma^2));
kai = 30;
a = kai*0.5;
b = a.^2;
func_L = a./((x).^2.5 + b);
ind = find(x>=25 & x<25+dx);
ind = ind(1);
func_L = func_L./func_L(ind).*func_gauss(ind);
scatterfunc = func_gauss;
scatterfunc(ind:end) = func_L(ind:end);

fwhm = 7.2;
sigma = fwhm./(2*sqrt(2*log(2)));
func_gauss = 0.2*exp(-(x-55).^2/(2*sigma^2));
kai = 40;
a = kai*0.5;
b = a.^2;
func_L = a./((x).^2 + b); 
ind = find(x>=55 & x<55+dx);
ind = ind(1);
func_L = func_L./func_L(ind).*func_gauss(ind);
func_gauss(ind:end) = func_L(ind:end);
scatterfunc = scatterfunc+func_gauss;
scatterfunc = scatterfunc./sum(scatterfunc); %normalized the probability to 1

fwhm = fwhm_zlp;
sigma = fwhm./(2*sqrt(2*log(2)));
f0 = exp(-(x-0).^2/(2*sigma^2));
kai = fwhm_loren;%fwhm of lorentzian is kai
a = kai*0.5;
b = a.^2;
fL = a./(x.^2 + b); 
f0 = conv(f0,fL,'same');

f = f0;
N = 10;
dx = thickness/N;


for i=1:N
    
    f = f.*(1-dx) + dx*conv(f,scatterfunc,'same');
    
end


