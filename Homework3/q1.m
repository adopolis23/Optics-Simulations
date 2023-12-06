clear all
close all

load("FDData_HW3.mat")


amp8_n = log((rho.^2) .* Amp_830)
amp6_n = log((rho.^2) .* Amp_690)

figure
plot(rho,amp6_n,"b")
xlabel('Rho');
ylabel('Amp');
legend('Amp');

figure
plot(rho,amp8_n,"b")
xlabel('Rho');
ylabel('Amp');
legend('Amp');

figure
plot(rho,Ph_690,"b")
xlabel('Rho');
ylabel('Phase');
legend('Phase');

figure
plot(rho,Ph_830,"b")
xlabel('Rho');
ylabel('Phase');
legend('Phase');


%fit for amp8_n
start_point = [-0.1, -0.9]
options = optimset('MaxFunEvals',1e11);
estimates = fminsearch(@(params) q1_model(params,rho, amp8_n), start_point, options);
[sse, FittedCurve] = q1_model(estimates, rho, amp8_n); % This statement is only required if you want to get the fits for all time points
residuals = amp8_n - FittedCurve
amp8_n_slope = estimates(1)

%fit for amp6_n
start_point = [-1, 1]
options = optimset('MaxFunEvals',1e11);
estimates = fminsearch(@(params) q1_model(params,rho, amp6_n), start_point, options);
[sse, FittedCurve] = q1_model(estimates, rho, amp6_n); % This statement is only required if you want to get the fits for all time points
residuals = amp6_n - FittedCurve
amp6_n_slope = estimates(1)

%fit for phase_6
start_point = [-1, 1]
options = optimset('MaxFunEvals',1e11);
estimates = fminsearch(@(params) q1_model(params,rho, Ph_690), start_point, options);
[sse, FittedCurve] = q1_model(estimates, rho, Ph_690); % This statement is only required if you want to get the fits for all time points
residuals = Ph_690 - FittedCurve
ph6_slope = estimates(1)

%fit for phase_8
start_point = [-1, 1]
options = optimset('MaxFunEvals',1e11);
estimates = fminsearch(@(params) q1_model(params,rho, Ph_830), start_point, options);
[sse, FittedCurve] = q1_model(estimates, rho, Ph_830); % This statement is only required if you want to get the fits for all time points
residuals = Ph_830 - FittedCurve
ph8_slope = estimates(1)

%plotting amp8_n fit
figure
subplot(3,1,[1 2])
plot(rho,ph8_slope,'bo',rho,FittedCurve,'r');
xlabel('Rho');
ylabel('Amplitude');
legend('Data','Fit');

subplot(3,1,3)
plot(rho,residuals,'ro');
xlabel('Rho');
ylabel('Residuals');

angfreq = 2 * 3.14159265 * 110 * 10^6
v = 3e10 / 1.4

mua_690 = (angfreq / (2*v)) * (ph6_slope/amp6_n_slope - amp6_n_slope/ph6_slope)
mus_690 = (2*v)/(3*angfreq) * amp6_n_slope * ph6_slope


mua_830 = (angfreq / (2*v)) * (ph8_slope/amp8_n_slope - amp8_n_slope/ph8_slope)
mus_830 = (2*v)/(angfreq) * amp8_n_slope * ph8_slope


