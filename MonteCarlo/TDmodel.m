function [sse, fittedcurve] =  TDmodel(params, rho, times, irf_n, nTissue, nOut, ydata)
% This function computes the homogeneous semi-infinite solution to TD-DOS
% with instrument response function
% fittedcurve     -- Estimated Fluence rate for 1W/cm2 input power convolved with irf
% mu_a            -- absorption coefficient cm-1
% mu_s            -- scattering coefficient cm-1
% rho             -- source detector separation
% t               -- time vector to compute TD solution
% irf_n           -- instrument response function
% nTissue         -- Refractive index of tissue
% nOut            -- Refractive index of medium

mu_a = params(1);
mu_s = params(2);

% define constants
c=3*10^10;               % speed of light in vaccuum
g = 0.91;
mu_sp = mu_s*(1-g);
nr = nTissue/nOut;
v = c/nTissue;      % speed of light in tissue

Reff = -(1.44/nr^2) + (0.701/nr) + 0.668 + (0.00636*nr);

D = v/(3*(mu_a+mu_sp));     %Photon Diffusion constant
ltr = 1/(mu_a+mu_sp);
zb = (2/3)*(ltr)*(1+Reff)/(1-Reff);
r1 = sqrt( rho.^2 + ltr^2 );
rb = sqrt( rho.^2 + (2*zb + ltr)^2);

% Time domain solution
t = times;
phi_TD = (v*1)*exp(-mu_a*v*t).*( exp(-(r1^2)./(4*D*t)) - exp(-(rb^2)./(4*D*t)) )./ power((4*pi*D*t),1.5);
% Normalizing
phi_TD = phi_TD/max(phi_TD);

% Convolving the irf with theortical phi
%phi_full = conv(phi_TD, irf_n);
%phic = abs(phi_full(1:length(t)));   % We want only the first part of the convolution
%phi = phic/max(phic);                % Normalize

fittedcurve = phi_TD;
sse = sum((ydata-phi_TD).^2);

end