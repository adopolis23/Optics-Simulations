clear all
close all
% Skeleton code for DCS fitting Question 3b
% Fill in '??' to complete the skeleton code

load('DCSData_HW3.mat');

mu_a  = 0.115;
mu_sp = 10;
lambda = 785;
nTissue = 1.4;
nOut = 1.4;         %Index matched media
beta = 0.5;
rho = 3;

nTimes = numel(TimeAxis);

% Fit one time-frame at a time
for n = 1:nTimes
    
    % Remember that g2_data is a two dimensional matrix 
    % One dimension corresponds to the delay time of an individual
    % autocorrelation curve, The second dimension corresponds to the time
    % stamps at which the autocorrelation curves are recorded.
    
    % Extract the nth g2 curve from g2_data
    g2_singleframe = g2_data(n,:)';
    
    % Identify xData and yData for a single time frame
    xData = DelayTimes;
    yData = g2_singleframe;
    
    start_point = [1e-8];
    options = optimset('MaxFunEvals',1e11);
    estimates = fminsearch(@(params) DCSmodel(params, beta, rho, mu_sp, mu_a, nTissue, nOut, lambda, xData, yData), start_point, options);
    [sse, FittedCurve] = DCSmodel(estimates, beta, rho, mu_sp, mu_a, nTissue, nOut, lambda, xData, yData); % This statement is only required if you want to get the fits for all time points
    
    %Store the nth BFI value
    BFI(n) = estimates;
   
end

% 3c. plotting for 100th time point
BFI100 = BFI(100);
[sse, FittedCurve100] = DCSmodel(BFI100, beta, rho, mu_sp, mu_a, nTissue, nOut, lambda, xData, g2_data(100,:));
figure

semilogx(DelayTimes,g2_data(100,:),'bo');   %The data goes here
hold on
semilogx(DelayTimes,FittedCurve100, 'r');   %The fit goes here



base_start = find(Marks == 1)
base_end = find(Marks == 2)

base_flow = mean(BFI(base_start:base_end))

rel_flow = BFI ./ base_flow


[B,TFrm,TFoutlier,L,U,C] = rmoutliers(rel_flow);


figure
%subplot(3,1,[1 2])
plot(find(~TFrm),B,"b")
xlabel('Time');
ylabel('Relative Flow');
legend('Flow');





