load("pO2_data.mat")


data = decaydata(100,:)


fun = @(params)model(params,decay_time,transpose(data));
params = fminsearch(fun, [1, 1, 1]);



[sse, fittedcurve] = model(params,decay_time,data);
residuals = data-fittedcurve

%{
%plotting
figure
subplot(3,1,[1 2])
plot(decay_time,decay_time,'bo',decay_time,fittedcurve,'r');
xlabel('Wavelength');
ylabel('Intensity');
legend('Data','Fit');

subplot(3,1,3)
plot(decay_time,residuals,'ro');
xlabel('Wavelength');
ylabel('Residuals');
%}