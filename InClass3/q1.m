clear all


%generate 10^4 uniform numbers
x = rand(1, 10^4)


%plot histogram
%histogram(x, "Normalization", "probability")


%generate new random numbers
x1 = StepSize([100.1], x)


%plot new histogram
hist = histogram(x1, 50, "Normalization", "pdf")
barHeights = hist.Values
binEdges = hist.BinEdges

x_axis = (binEdges(1:50)+binEdges(2:51))/2;

%x_axis = binEdges(1:50)




%plotting
%figure
%plot(binEdges,barHeights,'bo');
%xlabel('BinEdges');
%ylabel('BinHeight');




fun = @(params)model(params,x_axis,barHeights);
Options = optimset('MaxIter', 100000);
params = fminsearch(fun, [100]);



[sse, fittedcurve] = model(params,x_axis,barHeights);
residuals = barHeights-fittedcurve



%plotting
figure
subplot(3,1,[1 2])
plot(x_axis,barHeights,'bo',x_axis,fittedcurve,'r');
xlabel('Time');
ylabel('Data');
legend('Data','Fit');

subplot(3,1,3)
plot(x_axis,residuals,'ro');
xlabel('Time');
ylabel('Residuals');


