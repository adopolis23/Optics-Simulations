import math

def model_mueff(x, mueff):

    fittedcurve = (rho_1 * math.exp(-1 * mueff * x)) / (x * math.exp(-1 * mueff))