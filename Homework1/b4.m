clear all

load("pO2_data.mat")


taos = []


for i = 1:length(time_axis)

    data = decaydata(i,:)'

    fun = @(params)model(params,decay_time,data);

    Options = optimset('MaxIter', 100000);
    params = fminsearch(fun, [1, 1, 1]);

    taos = [taos params(2)]

end


tao_b = mean(taos(1:10))
kq = 307.7

oxygen_decay = partial_pressure([tao_b, kq], taos)



figure
plot(time_axis,oxygen_decay,'r');
xlabel('Time');
ylabel('Data');