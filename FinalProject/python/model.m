function [sse, fittedcurve] = model(params,xdata,ydata)

A = params(1);

%fittedcurve = (A.*exp(-xdata./B))+C

fittedcurve = (ydata(1) .* exp(-1 .* A .* xdata)) ./ (xdata .* exp(-1 * A))


sse = sum((ydata - fittedcurve).^2);