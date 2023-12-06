import math

def model(MuEff, xdata, ydata):
    sse = 0

    fittedcurve = xdata

    for i in range(len(xdata)):

        fittedcurve[i] = float((math.exp(-1 * MuEff * xdata[i])) / (xdata[i] * math.exp(-MuEff)))
    
        sse += (ydata[i] - fittedcurve[i])**2

    return sse, fittedcurve



