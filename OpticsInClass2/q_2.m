[theta, phasefn] = MiePhaseFnRead('filename')


angle = [-180:0.1:180]


invphasefn = flip(phasefn)

total_phase = [invphasefn(:,:); phasefn(2:end,1)];

plot(angle, total_phase)

xlabel("Angle(deg)")
ylabel("Phase Function")