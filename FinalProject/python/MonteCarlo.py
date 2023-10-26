#imports
import random
import math
import numpy as np
import matplotlib.pyplot as plt

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

#Number of photons to be simulated
Nphotons = 10000

#Photon survival parameters
epsilon = 0.0001
m = 10

#specular reflection
Rsp = ((nout - ntissue)**2) / ((nout + ntissue)**2)
Rs = Rsp*Nphotons


class Photon:
    def __init__(self):
        self.position = [0, 0, 0]
        
        #x, y, and z cosigns
        self.direction = [0, 0, 1]
        
        self.weight = 1
        
        #TODO maybe initialize Pathlength and Scoring Parameters
    
    
    #move photon a path lenth along direction vector
    def move(self, path_length):
        self.position[0] = self.position[0] + self.direction[0]*path_length
        self.position[1] = self.position[1] + self.direction[1]*path_length
        self.position[2] = self.position[2] + self.direction[2]*path_length
        
    def reduceWeight(self):
        new_w = self.weight - (self.weight * (mua / (mua + mus)))
        self.weight = new_w
    
    def updateDirection(self):
        theta = np.arccos((1/(2*g))*(1+g**2-((1-g**2)/(1-g+2*g*random.random()))**2))
        omega = 2 * math.pi * random.random()
        
        if self.direction[2] > 0.999:
            self.direction[0] = math.sin(theta) * math.cos(omega)
            self.direction[1] = math.sin(theta) * math.sin(omega)
            self.direction[2] = np.sign(self.direction[2]) * math.cos(theta)
        
        else:
            new_mux = math.sin(theta)*(self.direction[0]*self.direction[2]*math.cos(omega)-self.direction[1]*math.sin(omega))/(math.sqrt(1-(self.direction[2]**2)))+self.direction[0]*math.cos(theta)
            new_muy = math.sin(theta)*(self.direction[1]*self.direction[2]*math.cos(omega)+self.direction[0]*math.sin(omega))/(math.sqrt(1-(self.direction[2]**2)))+self.direction[1]*math.cos(theta)
            new_muz = -1 * math.sin(theta)*math.cos(omega)*math.sqrt(1-(self.direction[2]**2))+self.direction[2]*math.cos(theta)
                                       
            self.direction[0] = new_mux    
            self.direction[1] = new_muy  
            self.direction[2] = new_muz  
                                       
    
    def isAlive(self):
        if self.weight <= epsilon:

            if random.random() < (1/m):
                self.weight = m * self.weight
                return True

            #print("Weight < 0")
            return False
        return True
    
    def isInTissue(self):
        if self.position[2] < 0:
            #print("self.position[2] < 0")
            return False
        elif self.position[2] > thickness:
            #print("self.position[2] > thickness")
            return False
        return True
        



def progressBar(current, total, percentUpdate):
    delta = total * percentUpdate

    if current % delta == 0:
        percentage = str((current // delta) * percentUpdate * 100)
        print(str(percentage)+"%")
        #print(print("{} %".format(percentage)))

        
def stepFromDistrobution(x):
    return (-1 * math.log(x)) / mus 

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










#MAIN LOOP

pos_vec2d = [[], []]
for iteration in range(int(Nphotons)):
    pos_vec3d = [[], [], []]
    photon = Photon()
    
    progressBar(iteration, Nphotons, 0.01)

    while photon.isAlive():
        #save prev position and move to new position
        photon.move(path_length=stepFromDistrobution(random.random()))

        photon.reduceWeight()

        if photon.isInTissue() == False:
            #Update Reflection Transmission
            #print("Left Tissue")
            photon.weight = 0

        photon.updateDirection()
        

        #save positions for plotting
        if iteration == Nphotons-1:
            pos_vec3d[0].append(photon.position[0])
            pos_vec3d[1].append(photon.position[1])
            pos_vec3d[2].append(photon.position[2])
    
    pos_vec2d[0].append(photon.position[0])
    pos_vec2d[1].append(photon.position[1])


plotPoints2D(pos_vec2d[0], pos_vec2d[1])
plotPoints(pos_vec3d[0], pos_vec3d[1], pos_vec3d[2])
#plt.show()