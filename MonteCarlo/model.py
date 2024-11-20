import math

def model(x, mua, mus, sep):

    c=3*10^10            
    g = 0.91
    mu_sp = mus*(1-g)
    nr = 1.4/1.0
    v = c/1.4


    Reff = -(1.44/nr^2) + (0.701/nr) + 0.668 + (0.00636*nr)

    D = v/(3*(mua+mu_sp))
    ltr = 1/(mua+mu_sp)
    zb = (2/3)*(ltr)*(1+Reff)/(1-Reff)
    r1 = math.sqrt( sep**2 + ltr**2 )
    rb = math.sqrt( sep**2 + (2*zb + ltr)**2)

    t = x

    phi_TD = (v*1)*math.exp(-mua*v*t)*( math.exp(-(r1^2)/(4*D*t)) - math.exp(-(rb^2)/(4*D*t)) )/ math.power((4*math.pi*D*t),1.5)

    #phi_TD = phi_TD/max(phi_TD)

    return phi_TD


