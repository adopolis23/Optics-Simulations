function [sse, fittedcurve] = model(params,xdata,ydata)

A = params(1); %Ua
fittedcurve = (A)*exp(-(A).*xdata)
%fittedcurve = -1/(A+B) * log(xdata)

sse = sum((ydata - fittedcurve).^2);