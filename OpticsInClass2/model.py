
def model(params, xdata, ydata):
    if len(xdata) != len(ydata):
          print("Lengths of input vectors must be the same.")
          assert(False)

    A = params[0]
    B = params[1]

    fittedcurve = []
    sse = 0

    for i, x in enumerate(xdata):

        #Model Function Definition
        fittedcurve.append(
            (A * (xdata[i]**(-B)))
        )
        sse += ((ydata[i] - fittedcurve[i])**2)

    return sse, fittedcurve







