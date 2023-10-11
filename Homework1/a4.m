clear all

load("pO2_data.mat")


data = decaydata(100,:)'


fun = @(params)model(params,decay_time,data);
Options = optimset('MaxIter', 10000000);
params = fminsearch(fun, [10, 10, 10]);



[sse, fittedcurve] = model(params,decay_time,data);
residuals = data-fittedcurve


%plotting
figure
subplot(3,1,[1 2])
plot(decay_time,data,'bo',decay_time,fittedcurve,'r');
xlabel('Time');
ylabel('Data');
legend('Data','Fit');

subplot(3,1,3)
plot(decay_time,residuals,'ro');
xlabel('Time');
ylabel('Residuals');
