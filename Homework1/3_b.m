[theta, phasefn] = MiePhaseFnRead('3b_phasefunction.txt')


angle = [-180:0.1:180]


invphasefn = flip(phasefn)

total_phase = [invphasefn(:,:); phasefn(2:end,1)];

%plot(angle, total_phase)

%xlabel("Angle(deg)")
%ylabel("Phase Function")


fun = @(params)henyey(params,angle,total_phase);
params = fminsearch(fun, [0.5]);



[sse, fittedcurve] = henyey(params,angle,total_phase);
residuals = total_phase-fittedcurve

%plotting
figure
subplot(3,1,[1 2])
plot(angle,total_phase,'bo',angle,fittedcurve,'r');
xlabel('Wavelength');
ylabel('Intensity');
legend('Data','Fit');

subplot(3,1,3)
plot(angle,residuals,'ro');
xlabel('Wavelength');
ylabel('Residuals');