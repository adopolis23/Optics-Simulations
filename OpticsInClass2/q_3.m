[lambda, I] = MieWavelengthRead('q_3_sim.txt')


% Fitting
fun = @(parameters)model(parameters,lambda,I);
parameters = fminsearch(fun,[0 1]);

[sse, fittedcurve] = model(parameters,lambda,I);
residuals = I-fittedcurve





%plotting
figure
subplot(3,1,[1 2])
plot(lambda,I,'bo',lambda,fittedcurve,'r');
xlabel('Wavelength');
ylabel('Intensity');
legend('Data','Fit');

subplot(3,1,3)
plot(lambda,residuals,'ro');
xlabel('Wavelength');
ylabel('Residuals');
