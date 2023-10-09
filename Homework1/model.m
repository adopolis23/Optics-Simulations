function [sse, fittedcurve] = model(params,xdata,ydata)

A = params(1);
B = params(2);
C = params(3);

%fittedcurve = A*(1./(xdata.^B));
%fittedcurve = A*exp(-B.*xdata);
%fittedcurve = A*(xdata.^(-1.*B));

fittedcurve = A.*exp(xdata./B)+C

sse = sum((ydata - fittedcurve).^2);