from model import model
from loadphasefunction import load_phase_fn
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit


x_data, y_data = load_phase_fn("q_3_a0_sim.txt")

#x_data = x_data[:700]
#y_data = y_data[:700]


def model1(x, A, B):
    return (A * (x**(-B)))            


popt, pcov = curve_fit(model1, x_data, y_data, bounds=(0, [np.inf, np.inf]), maxfev=np.inf)
print(popt)

#sse, fittedcurve = model(popt, x_data, y_data)
fittedcurve = [model1(x, popt[0], popt[1]) for x in x_data]

plt.plot(x_data, y_data, color='b')
plt.plot(x_data, fittedcurve, color='r')
plt.show()




