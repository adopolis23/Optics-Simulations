clear all
load("DOS_Data2.mat")

base_start = find(Marks==1)
base_end = find(Marks==2)

M = [0.208, 0.115, 0.133]'
E = [epsilon635 ; epsilon785 ; epsilon830]
C = linsolve(E, M)

amp6_base = mean(Amp635(base_start:base_end))
amp7_base = mean(Amp785(base_start:base_end))
amp8_base = mean(Amp830(base_start:base_end))

deltaOD6 = log(Amp635/amp6_base)
deltaOD7 = log(Amp785/amp7_base)
deltaOD8 = log(Amp830/amp8_base)

deltaODM = [deltaOD6 deltaOD7 deltaOD8]

