function [fittedcurve] = partial_pressure(params,xdata)

A = params(1);
B = params(2);

fittedcurve = ((1./xdata) - (1/A)) / B;

