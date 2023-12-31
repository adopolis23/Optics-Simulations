close all
clear all

load("HistData.mat")
load("RhosData.mat")

Rhos1 = rhos(1:58)
Hist1 = hist(1:58)

figure
plot(Rhos1,Hist1,"b")
xlabel('Rho');
ylabel('Amp');
legend('Amp');


%fit for amp8_n
start_point = [1.6]
options = optimset('MaxFunEvals',1e13);
estimates = fminsearch(@(params) model(params,Rhos1, Hist1), start_point, options);
[sse, FittedCurve] = model(estimates, Rhos1, Hist1); % This statement is only required if you want to get the fits for all time points
residuals = Hist1 - FittedCurve



%plotting amp8_n fit
figure
subplot(3,1,[1 2])
plot(Rhos1,Hist1,'bo',Rhos1,FittedCurve,'r');
xlabel('Rho');
ylabel('Amplitude');
legend('Data','Fit');

subplot(3,1,3)
plot(Rhos1,residuals,'ro');
xlabel('Rho');
ylabel('Residuals');