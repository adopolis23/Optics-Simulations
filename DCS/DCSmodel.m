function [sse, FittedCurve] = DCSmodel(params,beta,rho, mu_sp, mu_a, n_tissue, n_medium, lambda, xData, yData)
        
% Skeleton code for DCSmodel to be used for fminsearch

% Fill in '??' to complete the skeleton code

     % Parameters fitted
        alphaDb = params(1); % Blood flow index (alpha x Db)
        
     % Finalizing constants for the model
        
        lambda = lambda*1e-7;       % Convert to cm
        k0 = 2*pi*n_tissue/lambda;  % magnitude of wave vector in tissue
        
        n = n_tissue/n_medium;      % Relative refractive index
              
        Reff = 0; % Effective Reflection coefficient           
            
        ltr = 1/(mu_a+mu_sp);        % z0 = Transp MFP = ltr
        zb = (2/3) * ltr * (1+Reff)/(1-Reff) ; %Extrapolated zero boundary condition
        z = 0;
        
        r1 = sqrt( rho^2 + (z-ltr)^2 );
        rb = sqrt( rho^2 + (z+(2*zb)+ltr)^2 );
        
        Kd  = sqrt( (3*mu_a*(mu_a+mu_sp)) + ((6*mu_sp*(mu_a+mu_sp)*(k0^2)*alphaDb*xData)) );       
        Kd0 = sqrt(  3*mu_a*(mu_a+mu_sp) );
        
        g1 = ( (rb*exp(-Kd*r1)) - (r1*exp(-Kd*rb)) )/( (rb*exp(-Kd0*r1)) - (r1*exp(-Kd0*rb)) );
        
      % Intensity autocorrelation function
        g2 = 1 + beta*( g1 ).^2;
        FittedCurve = g2;
        
      % Error between actual data (yData) and theoretical function
        ErrorVector = g2-yData;
        sse = sum(ErrorVector .^ 2);
        
end
    