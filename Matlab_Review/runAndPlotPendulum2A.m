%time vector
time_vec = 0:0.01:1

%initial angle
x0 = 10

%find value for each element in time_vec
for c = 1:numel(time_vec)
    solution(c) = pendulumDisp(x0, time_vec(c))
end

%plot
plot(time_vec, solution)


[maxima, maxI] = findpeaks(solution)

inverted_sol = solution.*-1

[minima, minI] = findpeaks(inverted_sol)

period_seconds = (minI(2)-minI(1))*0.01