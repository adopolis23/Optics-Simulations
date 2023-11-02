clear all
close all

load("DOSdata_HW2.mat")

base_start = find(Marks==1)
base_end = find(Marks==2)

%PART A

amp630 = I(:,1)
amp832 = I(:,2)

amp630_base = mean(amp630(base_start:base_end))
amp832_base = mean(amp832(base_start:base_end))

deltaOD6 = log(amp630/amp630_base)
deltaOD8 = log(amp832/amp832_base)

deltaODM = [deltaOD6 deltaOD8]

deltaMUA = deltaODM / 5

deltaC = linsolve(ext_coeff, deltaMUA')

HBO_vec = deltaC(1,:)'
HBR_vec = deltaC(2,:)'

figure
%subplot(3,1,[1 2])
plot(TimeAxis,HBO_vec,'b',TimeAxis,HBR_vec,'r');
xlabel('Time');
ylabel('Relative Concentration');
legend('HBO','HBR');



%PART B
dpf_arm = 4.16
deltaMUA_arm = deltaODM / dpf_arm
deltaC_arm = linsolve(ext_coeff, deltaMUA_arm')
HBO_vec_arm = deltaC_arm(1,:)'
HBR_vec_arm = deltaC_arm(2,:)'
figure
%subplot(3,1,[1 2])
plot(TimeAxis,HBO_vec_arm,'b',TimeAxis,HBR_vec_arm,'r');
xlabel('Time');
ylabel('Relative Concentration');
legend('HBO','HBR');
