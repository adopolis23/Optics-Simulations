function [fittedcurve] = StepSize(params,xdata)

A = params(1); %Ua

fittedcurve = -(1/(A)) * log(xdata)