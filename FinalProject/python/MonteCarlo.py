#imports
import random   
import math
import time
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from model import model
from modelMueff import model_mueff

#thickness of semi-infinite tissue (cm)
thickness = 50

#absorbtion and scattering coefficient (cm-1)
mua = 0.1
mus = 100.0

#Anisotropy Factor (unitless)
g = 0.91

#Refractive index of medium and surrounding
nout = 1.0
ntissue = 1.33

#speed of light in CM/SEC
v = 29979245800

#Number of photons to be simulated
N_total = 750000



#Photon survival parameters
epsilon = 0.001
m = 10

#specular reflection
Rsp = ((nout - ntissue)**2) / ((nout + ntissue)**2)
Rs = Rsp*N_total
Nphotons = int(N_total - Rs)

#source detector seperations to keep track of
source_detector_seperations = [1.0]

#sum of all photon weights reflected
total_weight_reflected = 0.0

#sum of all photon weights absorbed
total_weight_absorbed = 0.0

#weight absorbed and reflected 
absorbtion_matrix = []


class Photon:
    def __init__(self):
        self.position = [0.0, 0.0, 0.0]
        
        #x, y, and z cosigns
        self.direction = [0.0, 0.0, 1.0]
        
        self.weight = 1

        self.weight_absorbed = 0.0
        self.weight_reflected = 0.0

        self.total_dist_traveled = 0.0
        

        #TODO maybe initialize Pathlength and Scoring Parameters
    
    
    #move photon a path lenth along direction vector
    def move(self, path_length):
        self.position[0] = self.position[0] + self.direction[0]*path_length
        self.position[1] = self.position[1] + self.direction[1]*path_length
        self.position[2] = self.position[2] + self.direction[2]*path_length

        self.total_dist_traveled += path_length
        
    def reduceWeight(self):
        delta_w = (self.weight * (mua / (mua + mus)))
        new_w = self.weight - delta_w
        self.weight = new_w

        #keep track of total weight absorbed
        self.weight_absorbed = self.weight_absorbed + delta_w

        if self.weight < epsilon:
            if random.random() < (1/m):
                self.weight = m * self.weight
            else:
                self.weight_absorbed = self.weight_absorbed + photon.weight
                self.weight = 0
    
    def updateDirection(self):
        theta = np.arccos((1/(2*g))*(1+g**2-((1-g**2)/(1-g+2*g*random.random()))**2))
        omega = 2 * math.pi * random.random()
        
        if abs(self.direction[2]) > 0.999:
            self.direction[0] = math.sin(theta) * math.cos(omega)
            self.direction[1] = math.sin(theta) * math.sin(omega)
            self.direction[2] = np.sign(self.direction[2]) * math.cos(theta)
        
        else:
            #new_mux = math.sin(theta)*(self.direction[0]*self.direction[2]*math.cos(omega)-self.direction[1]*math.sin(omega))/(math.sqrt(1-(self.direction[2]**2)))+self.direction[0]*math.cos(theta)
            new_muy = math.sin(theta)*(self.direction[1]*self.direction[2]*math.cos(omega)+self.direction[0]*math.sin(omega))/(math.sqrt(1-(self.direction[2]**2)))+self.direction[1]*math.cos(theta)
            new_muz = -1 * math.sin(theta)*math.cos(omega)*math.sqrt(1-(self.direction[2]**2))+self.direction[2]*math.cos(theta)

            new_mux = math.sin(theta) * ((self.direction[0]*self.direction[2]*math.cos(omega) - self.direction[1]*math.sin(omega)) / (math.sqrt(1-self.direction[2]**2))) + self.direction[0] * math.cos(theta)

                                       
            self.direction[0] = new_mux    
            self.direction[1] = new_muy  
            self.direction[2] = new_muz  
                                       
    
    def isAlive(self):
        if self.weight <= epsilon:
            return False
        return True
    
    def isInTissue(self):
        if self.position[2] < 0 or self.position[2] > thickness:
            self.weight_reflected = self.weight_reflected + photon.weight
            return False
        return True
        









def progressBar(current, total, percentUpdate):
    delta = total * percentUpdate

    if current % delta == 0:
        percentage = str(int((current // delta) * percentUpdate * 100))
        print(percentage+"%")
        #print(print("{} %".format(percentage)))

        
def stepFromDistrobution(x):
    return (-1 * math.log(x)) / (mus) 

def plotPoints(x, y, z):
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.set_xlim(-1,1)
    ax.set_ylim(-1,1)
    ax.invert_zaxis()
    #ax.set_zlim(0.5,0)
    ax.scatter(x,y,z, c='r',s=1)
    ax.plot(x,y,z, color='r')
    
    px = np.linspace(-1, 1, 10)
    py = np.linspace(-1, 1, 10)

    px, py = np.meshgrid(px, py)
    eq = 0 * px + 0 * py + 0
    ax.plot_surface(px, py, eq, alpha=0.2)

    plt.show()




def plotPoints2D(x, y):
    fig2 = plt.figure()
    ax2 = fig2.add_subplot()
    ax2.set_xlim(-1,1)
    ax2.set_ylim(-1,1)
    #ax.set_zlim(0.5,0)
    ax2.scatter(x,y, c='r',s=0.1)
    #ax.plot(x,y,z, color='r')
    plt.show()


def plotSpatialHistogram(positions):
    distances = []
    for i in range(len(positions[0])):
        distances.append(math.sqrt(positions[0][i]**2 + positions[1][i]**2))

    fig, axs = plt.subplots(1, 1,
                            figsize =(10, 7), 
                            tight_layout = True)
    
    axs.hist(distances, bins=30)
    
    axs.set_title("Spatially Resolved Histogram")

    # Show plot
    plt.show()


#Time of flight data for reflected photons in a histogram
def source_detector_plot(positions, separation):
    tof = []

    for i in range(len(positions[0])):
        distance = math.sqrt(positions[0][i]**2 + positions[1][i]**2)

        
        dp = 0.1 * separation
        lower_bound = separation - dp
        upper_bound = separation + dp


        if distance > lower_bound and distance < upper_bound:
            tof.append(positions[3][i] / (v / ntissue))
            

    #fig, axs = plt.subplots(1, 1,
                            #figsize =(10, 7), 
                            #tight_layout = True)
    #axs.hist(tof, bins=100)
    #axs.set_title("Time Of Flight Histogram Separation = {}".format(separation))

    # Show plot
    #plt.show()

    counts, bins = np.histogram(tof, bins=100)
    bins = bins[:-1]
    plt.plot(bins, counts)
    plt.show()


    df = pd.DataFrame(counts)
    df.to_csv('tof' + str(separation).replace('.', '_') + '.csv') 

    df = pd.DataFrame(bins)
    df.to_csv('times' + str(separation).replace('.', '_') + '.csv') 

    
    

 

    
        




def fitAndEstimateMuEff(pos_vec2d):
    rhos = np.arange(0.1, 3.0, 0.05)
    hist = [0] * len(rhos)
    
    posAndWeight = []
    for i in range(len(pos_vec2d[0])):
        distance = math.sqrt(pos_vec2d[0][i]**2 + pos_vec2d[1][i]**2)
        posAndWeight.append([distance, pos_vec2d[2][i]])
    
    for i, rho in enumerate(rhos):
        dp = 0.1 * rho
        lower_bound = rho - (dp/2)
        upper_bound = rho + (dp/2)

        for x in posAndWeight:
            if x[0] > lower_bound and x[0] < upper_bound:
                hist[i] += x[1]
        
        #normalize for area of ring 
        hist[i] = hist[i] / (2 * math.pi * rho**2 * dp)


    hist = [x/hist[0] for x in hist]


    df = pd.DataFrame(rhos)
    df.to_csv('rhos.csv') 

    df = pd.DataFrame(hist)
    df.to_csv('hist.csv') 

    plt.plot(rhos, hist)
    plt.show()



#MAIN LOOP

#despite its misleading name this vector actually has 4 components - x-position, y-position, weight, total_path
pos_vec2d = [[], [], [], []]
start_time = time.time()

for iteration in range(Nphotons):
    pos_vec3d = [[], [], []]
    photon = Photon()
    
    progressBar(iteration, N_total, 0.01)

    while photon.isAlive():

        #save positions for plotting
        if iteration == int(Nphotons-1):
            pos_vec3d[0].append(photon.position[0])
            pos_vec3d[1].append(photon.position[1])
            pos_vec3d[2].append(photon.position[2])


        #move to new position
        photon.move(path_length=stepFromDistrobution(random.random()))

        photon.reduceWeight()

        if photon.isInTissue() == False:
            #Photon was reflected
            photon.weight = 0
            pos_vec2d[0].append(photon.position[0])
            pos_vec2d[1].append(photon.position[1])
            pos_vec2d[2].append(photon.weight_reflected)
            pos_vec2d[3].append(photon.total_dist_traveled)
        
        

        photon.updateDirection()
    
    absorbtion_matrix.append([photon.weight_absorbed, photon.weight_reflected, photon.weight_absorbed+photon.weight_reflected])
    total_weight_reflected = total_weight_reflected + photon.weight_reflected
    total_weight_absorbed = total_weight_absorbed + photon.weight_absorbed
        

elapsed_time = time.time() - start_time


total_fluence_5cm = 0.0
for i in range(len(pos_vec2d[0])):
    distance = math.sqrt(pos_vec2d[0][i]**2 + pos_vec2d[1][i]**2)
    if distance <= 5.0:
        total_fluence_5cm += pos_vec2d[2][i]
total_fluence_5cm = total_fluence_5cm / (2 * math.pi * 25.0)






#date print / plot
print("\n\nTotal simulation time = {} seconds".format(elapsed_time))
print("{} out of {} photons reflected.".format(len(pos_vec2d[0]), N_total))
print("Total Weight Absorbed = {} Total Weight Reflected = {}\n".format(total_weight_absorbed, (total_weight_reflected + Rs)))

print("Photon#   Weight Absorbed   Weight Reflected   Sum (First 20 Photons)\n")

for i in range(20):
    print("{}        {:.4f}        {:.4f}       {:.4f}".format(i, absorbtion_matrix[i][0], absorbtion_matrix[i][1], absorbtion_matrix[i][2]))

print("\n\n")

print("Total Fluence from 5.0cm around the origin is: {}".format(total_fluence_5cm))



source_detector_plot(pos_vec2d, 2.5)
#plotPoints2D(pos_vec2d[0], pos_vec2d[1])
#plotPoints(pos_vec3d[0], pos_vec3d[1], pos_vec3d[2])
#plotSpatialHistogram(pos_vec2d)
fitAndEstimateMuEff(pos_vec2d)


