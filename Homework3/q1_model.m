function [sse, fittedcurve] = q1_model(params,xdata,ydata)

M = params(1);
B = params(2);

%fittedcurve = (A.*exp(-xdata./B))+C

fittedcurve = (M * xdata) + B
sse = sum((ydata - fittedcurve).^2);