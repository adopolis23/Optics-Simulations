clear all

[theta, phasefn] = MiePhaseFnRead('3b_phasefunction.txt')


angle = [-180:0.1:180]


invphasefn = flip(phasefn)

total_phase = [invphasefn(:,:); phasefn(2:end,1)];

%plot(angle, total_phase)
%xlabel("Angle(deg)")
%ylabel("Phase Function")


angle2 = angle(1301:2301)'
total_phase2 = total_phase(1301:2301)


fun = @(params)henyey(params,angle2,total_phase2);
params = fminsearch(fun, [0.5]);



[sse, fittedcurve] = henyey(params,angle2,total_phase2);
residuals = total_phase2-fittedcurve;

%plotting
figure
subplot(3,1,[1 2])
plot(angle2,total_phase2,'bo',angle2,fittedcurve,'r');
xlabel('Wavelength');
ylabel('Intensity');
legend('Data','Fit');

subplot(3,1,3)
plot(angle2,residuals,'ro');
xlabel('Wavelength');
ylabel('Residuals');