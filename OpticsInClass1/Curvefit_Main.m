%Raw data
%tdata = 0:0.1:10;
%ydata = 40*exp(-0.5*tdata) + 3*randn(size(tdata));



%for 1% noise A=130.02 and Lambda=2.5662e+08
%for5% noise A=141.01 and Lambda=2.5807e+08



load("FluorLifeTime_Data05.mat")



% Fitting
fun = @(parameters)model(parameters,Taxis,FCounts);
parameters = fminsearch(fun,[0 1]);

[sse, fittedcurve] = model(parameters,Taxis,FCounts);
residuals = FCounts-fittedcurve



figure
subplot(3,1,[1 2])
plot(Taxis,FCounts,'bo',Taxis,fittedcurve,'r');
xlabel('x');
ylabel('F-Counts');
legend('Data','Fit');

subplot(3,1,3)
plot(Taxis,residuals,'ro');
xlabel('x');
ylabel('Residuals');

