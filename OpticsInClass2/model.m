function [sse, fittedcurve] = model(params,xdata,ydata)

A = params(1);
B = params(2);

%fittedcurve = A*exp(-lambda*xdata);
fittedcurve = A*(xdata.^(-1.*B));
sse = sum((ydata - fittedcurve).^2);