function [sse, fittedcurve] = model(params,xdata,ydata)

A = params(1);
lambda = params(2);

fittedcurve = A*exp(-lambda*xdata);
sse = sum((ydata - fittedcurve).^2);