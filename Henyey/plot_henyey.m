%angle vector
angle_vec = -180:1:180

%single value of g to test TODO: make this a vector
G = 0.30

%find value for each element in time_vec
for c = 1:numel(angle_vec)
    solution(c) = henyey(angle_vec(c), G)
end

%plot
plot(angle_vec, solution)