%% Read
%
clear all
close all

%load('TDData_HW3.mat');


tof=tof(1:100)
times=times(1:100)

figure
plot(times,tof,'b')
% Normalize by the Maximum value
tof_n = tof/max(tof);

% Plot the normalized TD data and irf
figure
plot(times, tof_n, 'b');
xlabel("time");
ylabel("Normalized Data");
%legend(TOF,IRF);

nTissue = 1.4;
nOut = 1.0;
rho = 2.5
irf_n = 1

%% Fit
start_point = [0.05, 20.0];
options = optimset('MaxFunEvals',1e10);
estimates = fminsearch(@(params)TDmodel(params, rho, times, irf_n, nTissue, nOut, tof_n), start_point, options);
[sse, FittedCurve] = TDmodel(estimates, rho, times, irf_n, nTissue, nOut, tof_n);
residuals = tof_n - FittedCurve

%% Plot the fit results
figure
subplot(3,1,[1 2])
plot(times,tof_n,'bo',times,FittedCurve,'r');
xlabel('Time');
ylabel('Data');
legend('Data','Fit');

subplot(3,1,3)
plot(times,residuals,'ro');
xlabel('Time');
ylabel('Residuals');